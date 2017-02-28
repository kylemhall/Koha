#!/usr/bin/perl

# This file is part of Koha.
#
# Copyright (C) 2012-2013 ByWater Solutions
#
# Koha is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# Koha is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Koha; if not, see <http://www.gnu.org/licenses>.

use Modern::Perl;
use Getopt::Long;
use Koha::SIP::Client;

my $help = 0;

my $host;
my $port = '6001';

my $login_user_id;
my $login_password;
my $location_code;

my $patron_identifier;
my $patron_password;

my $summary;

my $item_identifier;

my $fee_acknowledged = 0;

my $terminator = q{};

my @messages;

GetOptions(
    "a|address|host|hostaddress=s" => \$host,              # sip server ip
    "p|port=s"                     => \$port,              # sip server port
    "su|sip_user=s"                => \$login_user_id,     # sip user
    "sp|sip_pass=s"                => \$login_password,    # sip password
    "l|location|location_code=s"   => \$location_code,     # sip location code

    "patron=s"   => \$patron_identifier,    # patron cardnumber or login
    "password=s" => \$patron_password,      # patron's password

    "i|item=s" => \$item_identifier,

    "fa|fee-acknowledged" => \$fee_acknowledged,

    "s|summary=s" => \$summary,

    "t|terminator=s" => \$terminator,

    "m|message=s" => \@messages,

    'h|help|?' => \$help
);

my $client = Koha::SIP::Client->new(
    {
        host       => $host,              # sip server ip
        port       => $port,              # sip server port
        sip_user   => $login_user_id,     # sip user
        sip_pass   => $login_password,    # sip password
        location   => $location_code,     # sip location code
        terminator => $terminator,        # CR or CRLF
    }
);

my $response = $client->send(
    {
        message => 'login',
    }
);
say "SEND: " . $client->{raw_message};
say "READ: $response";

foreach my $message (@messages) {
    $response = $client->send(
        {
            message          => $message,
            patron           => $patron_identifier, # patron cardnumber or login
            password         => $patron_password,   # patron's password
            item             => $item_identifier,   # item barcode
            fee_acknowledged => $fee_acknowledged,
            summary          => $summary,
        }
    );
    say "SEND: " . $client->{raw_message};
    say "READ: $response";
}

if (   $help
    || !$host
    || !$login_user_id
    || !$login_password
    || !$location_code )
{
    say &help();
    exit();
}

sub help {
    say q/sip_cli_emulator.pl - SIP command line emulator

Test a SIP2 service by sending patron status and patron
information requests.

Usage:
  sip_cli_emulator.pl [OPTIONS]

Options:
  --help           display help message

  -a --address     SIP server ip address or host name
  -p --port        SIP server port

  -su --sip_user   SIP server login username
  -sp --sip_pass   SIP server login password

  -l --location    SIP location code

  --patron         ILS patron cardnumber or username
  --password       ILS patron password

  -s --summary     Optionally define the patron information request summary field.
                   Please refer to the SIP2 protocol specification for details

  --item           ILS item identifier ( item barcode )

  -t --terminator  SIP2 message terminator, either CR, or CRLF
                   (defaults to CRLF)

  -fa --fee-acknowledged Sends a confirmation of checkout fee

  -m --message     SIP2 message to execute

  Implemented Messages:
    patron_status_request
    patron_information
    item_information
    checkout
    checkin
    renew

/
}
