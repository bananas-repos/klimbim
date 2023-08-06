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


# 2012 by Johannes 'Banana' Keßler
# this file can be used as a "early morning check"

use warnings;
use strict;
use LWP::UserAgent;
use HTTP::Request;
use utf8;
use Term::ANSIColor qw(:constants);

my @urlsToCheck = ('http://url.tld','http://another.url.tld');

my $localtime     = localtime;
my ($day,$month,$date,$hour,$year) = split /\s+/,scalar localtime;
my $response_limit = 12; #seconds

print  "\n+" .('-' x 94) . "+\n";
print  "|", ' ' x 30,"Time: $hour",' ' x 50,"|\n";
print  "|",' 'x 10,'HOST',' ' x 37,'STATUS',' ' x 7, "RESPONSE",,' ' x 22,"|\n";
print "+" .('-' x 94) . "+\n";

# basich url access check
foreach my $url(@urlsToCheck) {
	# ordinary response check
	check_url($url);
	# special check which retuns the output.
	# eg. if you want to check the installed version. You could query the version info and display it
	check_url($url.'/_path/to/special/file/',"1");
}

print  "+" .('-' x 94) . "+\n";
print "\nProcess FINISH\n";



# 
# basic url check
#
sub check_url {  # subroutine who check given URL
    my ($target,$printResponse) = @_;
    
    my $ua = LWP::UserAgent->new;
    $ua->agent("$0/0.1 " . $ua->agent);
	#$ua->proxy(['http'], 'http://10.0.0.1:80/'); # proxy if you need one

	my $req = HTTP::Request->new(GET => "$target");
	$req->header('Accept' => 'text/html');
	# send request
	my $start = time;
	my $res = $ua->request($req);

	# debug messages
	# print $res->status_line."\n";
	# print $res->content."\n";
	
	# check the outcome
	if ($res->is_success) {
        # Success....all content of page has been received
		my $time = time; 
		my $out_format;

		$time = ($time - $start); # Result of timer
		if ($response_limit && ($response_limit <= $time)) {
			$out_format = sprintf "| %-50.50s %-10s %-30s |\n", $target, "SLOW", "Response $time seconds";
			print CLEAR, YELLOW, $out_format, RESET;
		} else {
			if($printResponse && $printResponse eq "1") { # this makes only sense if we have a success.
				$out_format = sprintf "| %-50.50s %-10s %-30s |\n", $target, "RESPONSE", trim($res->content);
				print CLEAR,GREEN, $out_format, RESET;
			}
			else {
				$out_format = sprintf "| %-50.50s %-10s %-30s |\n", $target, "ACCESSED", "Response $time seconds";	
				print CLEAR,GREEN, $out_format, RESET;

				# check if we have something we want in the response
				# this can be used to "validate" the response, seince a 202 can also en empty page...
				if($res->content =~ /someTextStringToCheck/) {
					my $out_format = sprintf "| %-50.50s %-10s %-30s |\n", '', "OK", "Content check ok";
					print  CLEAR, GREEN, $out_format, RESET;
				}
				else {
					my $out_format = sprintf "| %-50.50s %-10s %-30s |\n", '', "FALSE", "Missing content ?";
					print  BOLD, RED, $out_format, RESET;
				}
			}
		}
	} else { # Error .... Site is DOWN 
		my $out_format = sprintf "| %-50.50s %-10s %-30s |\n", $target, "DOWN", " N/A";
		print  BOLD, RED, $out_format, RESET;
   }
}

sub trim() {
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

# end file
