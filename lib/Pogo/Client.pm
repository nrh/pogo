package Pogo::Client;

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
use common::sense;

use Exporter 'import';
use JSON qw(encode_json);
use Log::Log4perl qw(:easy);
use HTTP::Request::Common qw(POST);

use Pogo::Common;
use Pogo::Engine::Response;

our $AUTOLOAD;

sub new
{
  my ( $class, $url ) = @_;
  my $self = { api => $url };
  DEBUG "api = $url";
  bless $self, $class;
  return $self;
}

sub ua
{
  return $Pogo::Common::USERAGENT;
}

# why are we overriding this again?
sub DESTROY { }

sub AUTOLOAD
{
  my ( $self, @stuff ) = @_;

  $AUTOLOAD =~ /(\w+)$/ or die "cannot parse '$AUTOLOAD'\n";
  my $method = $1;

  my $rpc = encode_json( [ $method, @stuff ] );
  my $post = POST $self->{api}, [ r => $rpc ];

  DEBUG $self->{api} . " request: $rpc";

  my $r = $self->ua->request($post);
  if ( $r->is_error )
  {
    my $resp = Pogo::Engine::Response->new( $r->decoded_content );
    ERROR "fatal error in request '$method': " . $r->status_line . "\n";
    return $resp;
  }

  DEBUG "response: " . $r->decoded_content;
  my $resp = Pogo::Engine::Response->new( $r->decoded_content );

  die "error from pogo server in request '$method': " . $resp->status_msg . "\n"
    unless $resp->is_success;

  return $resp;
}

1;

=pod

=head1 NAME

  CLASSNAME - SHORT DESCRIPTION

=head1 SYNOPSIS

CODE GOES HERE

=head1 DESCRIPTION

LONG_DESCRIPTION

=head1 METHODS

B<methodexample>

=over 2

methoddescription

=back

=head1 SEE ALSO

L<Pogo::Dispatcher>

=head1 COPYRIGHT

Apache 2.0

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

=cut

# vim:syn=perl:sw=2:ts=2:sts=2:et:fdm=marker
