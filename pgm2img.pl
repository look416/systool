#!/usr/bin/perl
use strict;
use warnings;

#user input the file name
print "Please enter the pgm file name: \n";
my $file = <STDIN>;

#do some validations and create the output file name

#print $file;
my @words = split '\.', $file;
#check the the file extension
if(! defined $words[1]){
	die "Invalid file type/extension";
}
chomp($words[1]);
if($words[1] ne "pgm"){
	die "Invalid file type/extension";
}

#open the file using the user input

open(TEST, $file) or die "Can't open file \n";

#set the handler to be in binary mode
binmode(TEST);

$/ = undef;
my $data = <TEST>;
close(TEST);

$data =~ /(..)\s([\d]+)\s([\d]+)\s([\d]+)/;
print "\n";
print "magic is $1\n";
print "width is $2\n";
print "height is $3\n";
print "maxval is $4\n";

my $dest = "$words[0]_$3_$2\.img";
my $total = $2 * $3;
my $line = `/usr/bin/tail --bytes=$total $file`;


# create and open the output file

unless (open FILE, '>'.$dest) {
	die "unable to create $dest\n"
}

print FILE $line;
close FILE;