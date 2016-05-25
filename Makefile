.PHONY: html deploy clean

DEPLOY_LIST=deploy-list.txt
DEPLOY_DIR=ant:~/public_html/grape-oslo

html: index.html
index.html: *.adoc
	@asciidoctor -a allow-uri-read -T asciidoctor-reveal.js/templates/slim oslo.adoc -o index.html

$(DEPLOY_LIST):
	@echo assets > $(DEPLOY_LIST)
	@echo css >> $(DEPLOY_LIST)
	@echo index.html >> $(DEPLOY_LIST)
	@echo reveal.js >> $(DEPLOY_LIST)

deploy: html $(DEPLOY_LIST)
	rsync -arL --files-from=$(DEPLOY_LIST) --exclude=node_modules . $(DEPLOY_DIR)

serve: html
	@ps | grep SimpleHTTPServer | grep -v grep >/dev/null || (python -m SimpleHTTPServer &> .http.log & echo $$! > .http.pid)

unserve: .http.pid
	@kill $$(cat .http.pid)
	@rm -rf .http.{log,pid}

presentation: serve
	@open http://localhost:8000

clean:
	rm -rf $(DEPLOY_LIST) index.html