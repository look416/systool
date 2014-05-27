#!/usr/bin/perl
use strict;
use warnings;

#user input the file name
print "Please enter the pgm file name: \n";
my $file = <STDIN>;
#open the file using the user input


#do some validations
#print $file;
my @words = split '\.', $file;
#check the the file extension
if(! defined $words[1]){
	die "Invalid file type/extension";
}
print $words[1];
chomp($words[1]);
if($words[1] ne "img"){
	die "Invalid file type/extension";
}

my @variables = split'_', $words[0];
print "@variables\n";

#my $dest = "$words[0]_$3_$2\.img";

#my $total = $2 * $3;
#my $line = `/usr/bin/tail --bytes=$total $file`;



#open(TEST, $file) or die "Can't open file \n";
