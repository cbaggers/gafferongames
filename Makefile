.PHONY: public clean local upload commit

public: 
	rm -rf public
	rm -f config.toml
	cp config_upload.toml config.toml
	hugo

local:
	rm -f config.toml
	cp config_local.toml config.toml
	bash -c "sleep 1.0 && open http://127.0.0.1:1313" &
	hugo server --watch --verbose -D -F
	rm -f config.toml

upload:
	rm -rf public
	rm -f config.toml
	cp config_upload.toml config.toml
	hugo
	mv public gafferongames_upload
	zip -9r gafferongames_upload.zip gafferongames_upload
	scp gafferongames_upload.zip root@linux:~/www
	rm gafferongames_upload.zip
	rm -rf gafferongames_upload
	ssh root@linux "cd ~/www && unzip gafferongames_upload.zip && rm -rf gafferongames_old && mv gafferongames gafferongames_old && mv gafferongames_upload gafferongames && rm -rf gafferongames_old"
	open http://linux/gafferongames
	rm -f config.toml

commit:
	rm -rf gafferongames
	rm -f config.toml
	git add .
	git commit -am "commit"
	git push

clean: 
	rm -rf public
	rm -f config.toml
