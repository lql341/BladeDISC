#!/bin/bash
# Copyright 2021 The BladeDISC Authors. All rights reserved.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.



SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source ${SCRIPT_DIR}/deploy_docker.sh

# build runtime Docker
docker build -t ${REMOTE_RUNTIME_DOCKER} -f docker/runtime/Dockerfile.pytorch \
  --build-arg BASEIMAGE=${RUNTIME_BASEIMAGE} .


# push TorchBlade runtime Docker images
push_images
