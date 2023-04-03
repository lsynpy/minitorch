FROM registry.cn-hangzhou.aliyuncs.com/cwpypy/dev:latest
ARG HOME=/home/dev

# prepare virtual env, some lib only compatible with python < 3.11
RUN  CONFIGURE_OPTS="--with-openssl=$(brew --prefix openssl)" pyenv install 3.10
RUN pyenv uninstall minitorch || :
RUN pyenv virtualenv 3.10 minitorch

# fix permission
# macos docker behave wired. when run with mount, `minitorch` dir owner is root, restart then `exec -it`
# login again, owner is `dev`
RUN mkdir -p ${HOME}/code
RUN chown -R dev:dev ${HOME}/code