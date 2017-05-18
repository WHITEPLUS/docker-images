FROM buildpack-deps:jessie

RUN /bin/cp -f /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
 && sed -i "s/httpredir\\.debian\\.org/cdn.debian.net/" /etc/apt/sources.list \
 && sed -i "s/jessie main/jessie main contrib non-free/" /etc/apt/sources.list \
 \
 && apt-get update 1> /dev/null \
 && apt-get upgrade -y -q --no-install-recommends \
 \
 && apt-get install -y --no-install-recommends \
 ca-certificates curl git zip jq vim \
 python python-yaml \
 python-pip python-dev libffi-dev \
 libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng12-dev libtidy-dev libssl-dev \
 apt-transport-https ttf-wqy-zenhei ttf-unfonts-core \
 \
 && apt-get -y --purge remove python-cffi \
 \
 && pip install --upgrade cffi \
 && pip install awscli \
 && pip install ansible \
 \
 && apt-get -f -y --auto-remove remove \
 python-pip python-dev libffi-dev \
 \
 && apt-get clean \
 \
 && rm -rf /var/lib/apt/lists/* /var/cache/apt/* /tmp/*

RUN curl -q https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
 && echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >| /etc/apt/sources.list.d/google-chrome.list \
 && apt-get update -qqy \
 && apt-get -qqy install google-chrome-unstable \
 && rm /etc/apt/sources.list.d/google-chrome.list \
 && rm -rf /var/lib/apt/lists/* /var/cache/apt/* /tmp/*

ENV YARN_VERSION 0.21.3
ENV YARN_GPG_KEY 6A010C5166006599AA17F08146C2130DFD2497F5
RUN set -ex \
 && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$YARN_GPG_KEY" \
 && curl -fSL -o yarn.js "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-legacy-$YARN_VERSION.js" \
 && curl -fSL -o yarn.js.asc "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-legacy-$YARN_VERSION.js.asc" \
 && gpg --batch --verify yarn.js.asc yarn.js \
 && rm yarn.js.asc \
 && mv yarn.js /usr/local/bin/yarn \
 && chmod +x /usr/local/bin/yarn \
 && rm -rf /tmp/*

ENV ANY_ENV_HOME /root/.anyenv
ENV PATH $ANY_ENV_HOME/bin:$PATH
COPY ansible /tmp/ansible
WORKDIR /tmp/ansible
RUN mkdir -p /etc/ansible \
 && echo 'localhost' >| /etc/ansible/hosts \
 && ansible-playbook -vvv playbook.yml \
 && rm -rf /tmp/*

WORKDIR /root
