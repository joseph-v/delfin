# Copyright 2020 The SODA Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM ubuntu:18.04

RUN apt-get update -y && \
    apt-get install -y python3-pip && \
    apt-get install -y sqlite3 && \
    apt-get install -y libffi-dev

ADD . /delfin
WORKDIR /delfin

RUN mkdir -p /var/log/delfin
RUN mkdir -p /var/lib/delfin/

RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

COPY etc/delfin/api-paste.ini /etc/delfin/api-paste.ini
COPY etc/delfin/delfin.conf /etc/delfin/delfin.conf
COPY etc/scheduler_config.json /etc/delfin/scheduler_config.json

COPY script/start.sh start.sh

CMD ./start.sh
