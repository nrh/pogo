package Pogo::Plugin::Root::DummyRoot2;

# Copyright (c) 2010-2011 Yahoo! Inc. All rights reserved.
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

use 5.008;

sub new
{
  my $self = {};
  bless $self;
  return $self;
}

sub root_type { return "dummyroot2"; }
sub transform { return "dummyroot2 \${rootname} --cmd \${command}"; }
sub priority  { return 5; }

1;
