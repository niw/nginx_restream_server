.PHONY: all
all: nginx/objs/ngx_rtmp_module.so

nginx-rtmp-module/config:
	git submodule update --init

nginx:
	brew ruby scripts/stage_homebrew_package.rb nginx $@

nginx/objs/ngx_rtmp_module.so: nginx nginx-rtmp-module/config scripts/configure.sh
	cd nginx && bash ../scripts/configure.sh && make modules

nginx.conf: templates/nginx.conf.erb config.yml
	cat templates/nginx.conf.erb | ruby scripts/process_erb_template.rb -c config.yml > $@

logs:
	mkdir -p logs

.PHONY: run
run: nginx.conf logs
	nginx -p `pwd` -c nginx.conf

.PHONY: clean
clean:
	git clean -dfX
