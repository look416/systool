#!/usr/bin/perl
use strict;
use warnings;

unless (open FILE, '>'."dump.txt") {
	die "unable to create dump.txt\n"
}

#my $line = `/usr/bin/hexdump test_512_512.smg`;
my $line = `/usr/bin/hexdump test_threshold_output.pgm`;

print FILE $line;

close FILE;