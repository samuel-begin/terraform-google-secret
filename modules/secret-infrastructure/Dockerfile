# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM ubuntu:bionic

RUN apt-get update -y && \
    apt-get install -y software-properties-common && \
    apt-add-repository -y ppa:rael-gc/rvm && \
    apt-get update -y && \
    apt-get install rvm -y && \
    /bin/bash -l -c "rvm install 2.4.2 && \
    echo 'gem: --no-ri --no-rdoc' > ~/.gemrc && \
    gem install bundler --no-ri --no-rdoc"

RUN apt-get install -y unzip wget ssh git && \
    wget https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip && \
    unzip terraform_0.11.11_linux_amd64.zip && \
    mv terraform /usr/local/bin/

RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update -y && apt-get install google-cloud-sdk -y

COPY Gemfile ./
RUN /bin/bash -l -c "bundle install"

ENV WORKDIR /root/static_build
WORKDIR $WORKDIR
COPY . .
ARG GOOGLE_APPLICATION_CREDENTIALS
ENV CREDENTIALS_FILE credentials.json
COPY $GOOGLE_APPLICATION_CREDENTIALS $WORKDIR/$CREDENTIALS_FILE
ENV GOOGLE_APPLICATION_CREDENTIALS=$WORKDIR/$CREDENTIALS_FILE
ARG RANDOM_SUFFIX
ENV RANDOM_SUFFIX=$RANDOM_SUFFIX

RUN echo "alias tf_list=\"/bin/bash -l -c 'bundle exec kitchen list'\"" >> /root/.bashrc && \
    echo "alias tf_destroy=\"/bin/bash -l -c 'bundle exec kitchen destroy ; bundle exec kitchen list'\"" >> /root/.bashrc && \
    echo "alias tf_test=\"/bin/bash -l -c 'bundle exec kitchen create && bundle exec kitchen converge && bundle exec kitchen verify ; bundle exec kitchen list'\"" >> /root/.bashrc && \
    echo "alias tf_test_and_destroy=\"/bin/bash -l -c 'bundle exec kitchen create && bundle exec kitchen test --destroy always'\"" >> /root/.bashrc

ARG PROJECT_NAME
ENV PROJECT_NAME=$PROJECT_NAME
RUN /bin/bash -l -c 'bundle exec kitchen create && bundle exec kitchen converge ; bundle exec kitchen converge && bundle exec kitchen verify && bundle exec kitchen destroy'