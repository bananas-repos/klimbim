#!/usr/bin/perl -w

# Klimbim Software collection, A bag full of things
# Copyright (C) 2011-2023 Johannes 'Banana' Keßler
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.


# 2020 by Johannes 'Banana' Keßler
# some improved simple page load check script.
# multiple URL and how ofthen they are accessed

use warnings;
use strict;
use LWP::UserAgent;
use HTTP::Request;
use HTTP::Cookies;
use utf8;
use Time::HiRes qw/ time sleep /;

my @urlsToCheck = (
	'https://www.some.tld'
	'https://www.some.tld/with/path',
	'https://www.some-other.tld'
);
my @timesToCheck = (1..10);

my $localtime = localtime;
my ($day,$month,$date,$hour,$year) = split /\s+/,scalar localtime;

my $request_headers = [
  'user-agent' => 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/999.99 (KHTML, like Gecko) Chrome/79.0.3945.131 Safari/537.36',
  'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
  'Accept-Charset' => 'iso-8859-1,*,utf-8', 
  'Accept-Language' => 'en-US',
  'accept-encoding' => 'gzip, deflate, br',
  'Cache-Control' => 'no-cache',
];

#
#$ua->cookie_jar(HTTP::Cookies->new(file => "$ENV{HOME}/.cookies.txt"));
my $cookies = HTTP::Cookies->new();
# set_cookie( $version, $key, $val, $path, $domain, $port, $path_spec, $secure, $maxage, $discard, \%rest )
$cookies->set_cookie(0,'name', 'value','/','www.some.tld');


print  "\n+" .('-' x 90) . "+\n";
print  "|", " Time: $hour",' ' x 75,"|\n";
print  "|", ' URL',' ' x 70,'TIME',' ' x 12,"|\n";
print "+" .('-' x 90) . "+\n";


foreach my $url(@urlsToCheck) {
	for (@timesToCheck) {
		check_url($url);
	}
}

sub check_url {
	my ($target) = @_;

	my $ua = LWP::UserAgent->new;
	$ua->cookie_jar($cookies);
    my $req = HTTP::Request->new(GET => $target, $request_headers);

    my $start = time;
	my $res = $ua->request($req);

	if ($res->is_success) {
		my $time = time;
		$time = ($time - $start);
		my $displayUrl = substr($target, -70);

		my $out = sprintf "%-74s %.4f sec \n", $displayUrl, $time;
		print $out;
	}
}
