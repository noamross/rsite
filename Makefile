SHELL := /bin/bash

# Rsync files to the host, make sure shell scripts are runnable
transfer: protected .env
	source .env \
	&& mkdir -p ~/.ssh; echo $$SSH_HOST_KEY >> ~/.ssh/known_hosts \
	&& chmod 400 $$SSH_KEYFILE \
	&& rsync -avzP --delete --exclude 'renv/library' --exclude 'renv/local' --exclude 'renv/staging' --exclude 'renv/lock' --exclude 'renv/python' -e "ssh -i `pwd`/$$SSH_KEYFILE" protected/ $$SSH_USER@$$SSH_HOST:/home/protected/ \
	&& rsync -avzP --delete --exclude '.well-known' -e "ssh -i `pwd`/$$SSH_KEYFILE" public/ $$SSH_USER@$$SSH_HOST:/home/public/ \
	&& rsync -avzP --delete -e "ssh -i `pwd`/$$SSH_KEYFILE" .env $$SSH_USER@$$SSH_HOST:/home/private/.env \
	&& ssh -i `pwd`/$$SSH_KEYFILE $$SSH_USER@$$SSH_HOST chmod a+x /home/protected/*.R

# Update R packages if needed
update:
	source .env \
	&& ssh -i `pwd`/$$SSH_KEYFILE $$SSH_USER@$$SSH_HOST "cd /home/protected; ./restore-packages.R" \
	&& ssh -i `pwd`/$$SSH_KEYFILE $$SSH_USER@$$SSH_HOST nfsn stop-daemon plumber || true \
	&& ssh -i `pwd`/$$SSH_KEYFILE $$SSH_USER@$$SSH_HOST nfsn start-daemon plumber \
	&& ssh -i `pwd`/$$SSH_KEYFILE $$SSH_USER@$$SSH_HOST nfsn stop-daemon shiny || true #\
#	&& # ssh -i `pwd`/$$SSH_KEYFILE $$SSH_USER@$$SSH_HOST nfsn start-daemon shiny

.PHONY: transfer update
