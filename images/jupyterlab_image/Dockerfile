# Copyright 2019, The TensorFlow Federated Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# This Dockerfile is used to create a Docker image of the TensorFlow Federated
# (TFF) remote executor service from a released version of TFF. Pass
# --build-arg VERSION=X.Y.Z to docker build to specify the release number.
FROM gcr.io/deeplearning-platform-release/base-cpu

ARG VERSION

RUN test -n "${VERSION}"

RUN apt-get update && apt-get install -y apt-transport-https gnupg2 curl \
&& curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
&& echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
&& apt-get update \
&& apt-get install -y kubectl

RUN pip install --no-cache-dir --upgrade pip \
&& pip install --no-cache-dir --upgrade "tensorflow-federated==${VERSION}" nest_asyncio \
&& pip freeze

