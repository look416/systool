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
#print $words[1];
chomp($words[1]);
if($words[1] ne "img"){
	die "Invalid file type/extension";
}

my @variables = split'_', $words[0];
#print "@variables\n";

#check whether the filename consist of enough information
if((my $size = @variables) != 3){
    die "Invalid file name, not enough information";   
}

my $dest = "$variables[0]_output\.pgm";

my $total = $variables[2] * $variables[1];
chomp($file);
my $size = -s $file;
#print "$size\n";

if($size != $total){
	die "Invalid file size.";
}

#read the img and store it into the variable
open(TEST, $file) or die "Can't open file \n";

#set the handler to be in binary mode
binmode(TEST);

$/ = undef;
my $data = <TEST>;
close(TEST);

#write the img file into pgm
unless (open FILE, '>'.$dest) {
	die "unable to create $dest\n"
}

print FILE "P5\n";
print FILE "$variables[2]\n";
print FILE "$variables[1]\n";
print FILE "255\n";
print FILE $data;
close FILE;
