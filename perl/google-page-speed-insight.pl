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
# get Google page spedd insight data fpr given URLs
# https://developers.google.com/speed/pagespeed/insights/
# https://developers.google.com/speed/docs/insights/v5/reference/pagespeedapi/runpagespeed#response

# retrieves the json and stores it into a file.

use warnings;
use strict;
use LWP::UserAgent;
use HTTP::Request;
use utf8;
use JSON;
use URI::Encode qw(uri_encode uri_decode);

my $localtime = localtime;
my ($day,$month,$date,$hour,$year) = split /\s+/,scalar localtime;

my @urlsToCheck = (
	'https://www.some.tld',
	'https://www.some.tld/with/path',
	'https://www.some-other.tld'
);

my $request_headers = [
  'user-agent' => 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/999.99 (KHTML, like Gecko) Chrome/79.0.3945.131 Safari/537.36',
  'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
  'Accept-Charset' => 'iso-8859-1,*,utf-8',
  'Accept-Language' => 'en-US',
  'accept-encoding' => 'gzip, deflate, br',
  'Cache-Control' => 'no-cache',
];

my $runFilename = $year."-".$month."-".$day.".log";
open(my $fh, '>>', $runFilename) or die "Could not open file '$runFilename' $!";

print "Getting page speed info from:\n";
foreach my $url(@urlsToCheck) {
	print $url."\n";
	print $fh $url;

	check_url($url);
	sleep(rand(10));
}

close $fh;

sub check_url {
	my ($target) = @_;
	$target = "https://www.googleapis.com/pagespeedonline/v5/runPagespeed?url=".uri_encode($target);

	my $ua = LWP::UserAgent->new;
	#$ua->proxy(['https','http'], 'http://10.0.0.1:80/'); # proxy if you need one
    my $req = HTTP::Request->new(GET => $target, $request_headers);
	my $res = $ua->request($req);

	if ($res->is_success) {
		my $resultData = $res->decoded_content();


		my $jsonData = decode_json($resultData);
		my $score = $jsonData->{'lighthouseResult'}->{'categories'}->{'performance'}->{'score'};
		print "Score: ".$score."\n";

		$resultData =~ s/\R//g;
		print $fh " ".$score." ".$resultData."\n";
	}
	else {
		print $res->code ."\n";
		print $res->status_line ."\n";
		print "Something went wrong\n";
	}
}
