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

###########################################
package PasswordMonkey::Filler::PogoPassword;
###########################################
use strict;
use warnings;
our $VERSION = 0.01;

use base qw(PasswordMonkey::Filler);

###########################################
sub init  {
###########################################
    my($self) = @_;

    $self->dealbreakers([ 
     ["Sorry, try again."                    => 255],
     ["Mismatch; try again, EOF to quit."    => 255],
     ["New password:"                        => 255],
     ["Retype new password:"                 => 255],
     ["Permission denied, please try again." => 255],
    ]);
}

###########################################
sub pre_filler  {
###########################################
    my($self) = @_;

    $self->expect->send_user(" (supplied by pogo-pw)");
}

###########################################
sub prompt  {
###########################################
    return qr((\[sudo\] password for [\w_]+|assword):\s*);
}

1;

__END__

=head1 NAME

PasswordMonkey::Filler::PogoPassword - Pogo password provider

=head1 SYNOPSIS

    use PasswordMonkey::Filler::PogoPassword;

=head1 DESCRIPTION

Just sends the password when prompted with "assword:" or a sudo prompt.

This bundle also contains PasswordMonkey::Filler::YinstPkgPassphrase and
PasswordMonkey::Filler::PogoGPG.

=head1 AUTHORS

  Andrew Sloane <andy@a1k0n.net>
  Ian Bettinger <ibettinger@yahoo.com>
  Michael Fischer <michael+pogo@dynamine.net>
  Mike Schilli <m@perlmeister.com>
  Nicholas Harteau <nrh@hep.cat>
  Nick Purvis <nep@noisetu.be>
  Robert Phan <robert.phan@gmail.com>
  Srini Singanallur <ssingan@yahoo.com>
  Yogesh Natarajan <yogesh_ny@yahoo.co.in>

2011, Mike Schilli <mschilli@yahoo-inc.com>

