.PHONY: html deploy clean

DEPLOY_LIST=deploy-list.txt
DEPLOY_DIR=ant:~/public_html/ngs-grape

html: index.html
index.html:
	@asciidoctor -a allow-uri-read -T ~/workspace/asciidoctor-reveal.js/templates/slim ngs.adoc -o index.html

$(DEPLOY_LIST):
	@echo assets > $(DEPLOY_LIST)
	@echo css >> $(DEPLOY_LIST)
	@echo index.html >> $(DEPLOY_LIST)
	@echo reveal.js >> $(DEPLOY_LIST)

deploy: html $(DEPLOY_LIST)
	rsync -arL --files-from=$(DEPLOY_LIST) --exclude=node_modules . $(DEPLOY_DIR)

clean:
	rm $(DEPLOY_LIST) index.html