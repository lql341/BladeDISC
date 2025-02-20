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


set -ex
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# RuntimeError: Click will abort further execution because Python was configured to use ASCII as encoding for the environment. Consult https://click.palletsprojects.com/unicode-support/ for mitigation steps.
# This system supports the C.UTF-8 locale which is recommended. You might be able to resolve your issue by exporting the following environment variables:
export LC_ALL=C.UTF-8
export LANG=C.UTF-8

# note(yancey.yx): using virtualenv to avoid permission issue on workflow actions CI,
python -m virtualenv venv && source venv/bin/activate

(cd tensorflow_blade \
  && python -m pip install -q -r requirement-tf2.4-cu110.txt \
  && ./build.py ../venv/ -s configure \
  && ./build.py ../venv/ -s check \
  && ./build.py ../venv/ -s build \
  && ./build.py ../venv/ -s test)

deactivate
