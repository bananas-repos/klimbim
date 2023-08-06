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
# some simple URL load check with running
# headless (or not) chrome

use warnings;
use strict;
use utf8;

use WWW::Mechanize::Chrome;
use Log::Log4perl qw(:easy);
use Time::HiRes qw/ time sleep /;
use File::Temp 'tempdir';

# how often each url will be called
my @timesToCheck = (1..10);
# the urls to be called
my @urlsToCheck = (
	'https://www.some.tld',
	'https://www.some.tld/with/path',
	'https://www.some-other.tld'
);

my $mech = WWW::Mechanize::Chrome->new(
	launch_exe => '/usr/bin/google-chrome-stable', # path to your chome
	incognito => 1,
	data_directory => tempdir(CLEANUP => 1 ),
	launch_arg => [
		#"--headless", # headless or not
		"--disk-cache-dir=/dev/null",
		"--aggressive-cache-discard",
		"--disable-gpu",
		"--deterministic-mode",
		"--disk-cache-size=1",
		"--no-sandbox"
	],
	cookie_jar => {}
);

$mech->add_header(
	'user-agent' => 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/999.99 (KHTML, like Gecko) Chrome/79.0.3945.131 Safari/537.36',
	'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
	'Accept-Charset' => 'iso-8859-1,*,utf-8',
	'Accept-Language' => 'en-US',
	'accept-encoding' => 'gzip, deflate, br',
	'Cache-Control' => 'no-cache',
);


foreach my $url(@urlsToCheck) {
	my $displayUrl = substr($url, -70);

	for (@timesToCheck) {
		my $start = time;
		$mech->get($url.'?'.$start);
		if ($mech->success()) {
			my $time = time;
			$time = ($time - $start);

			my $out = sprintf "%s %.4f sec \n", $displayUrl, $time;
			print $out;
		}
		$mech->sleep( 2 );
	}
}
$mech->close();