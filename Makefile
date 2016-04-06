DEPLOY_LIST=deploy-list.txt
DEPLOY_DIR=ant:~/public_html/ngs-grape

html: index.html
	@asciidoctor -a allow-uri-read -T ~/workspace/asciidoctor-reveal.js/templates/slim ngs.adoc -o index.html

deploy: html
	rsync -arL --files-from=$(DEPLOY_LIST) --exclude=node_modules . $(DEPLOY_DIR)