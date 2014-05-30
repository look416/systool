#!/usr/bin/perl
use strict;
use warnings;
use POSIX;

my $one_byte = 0;
my $arr = "hilo";

#do validations on command line arguments
#validate the number of arguments
my $num_args = $#ARGV + 1;
if ($num_args != 2 && $num_args != 3 && $num_args != 1){
	print "\nUsage: smg2pgm.pl file_name [lohi/hilo] [one_byte]\n";
	exit;
}

#validate the options when num args is 2
if($num_args == 2){
	my $arg1 = $ARGV[1];
	if($arg1 ne "lohi" && $arg1 ne "hilo" && $arg1 ne "one_byte"){
		print "\nUsage: smg2pgm.pl file_name [lohi/hilo] [one_byte]\n";
		exit;
	}
	if($arg1 eq "lohi"){
		$arr = "lohi";
	}elsif($arg1 eq "one_byte"){
		$one_byte = 1;
	}
}

#validate the options when num args is 3
if($num_args == 3){
	my $arg1 = $ARGV[1];
	my $arg2 = $ARGV[2];
	#print "$arg1\n";
	if($arg1 ne "lohi" && $arg1 ne "hilo" || $arg2 ne "one_byte"){
		print "\nUsage: smg2pgm.pl file_name  [lohi/hilo] [one_byte]\n";
		exit;
	}
	if($arg1 eq "lohi" && $arg2 eq "one_byte"){
		$arr = "lohi";
		$one_byte = 1;
	}else {
		$one_byte = 1;
	}
}

#print "$arr , $one_byte\n";

#some working on smg file

my $file = $ARGV[0];
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
if($words[1] ne "smg"){
	die "Invalid file type/extension";
}

my @variables = split'_', $words[0];

#check whether the filename consist of enough information
if((my $size = @variables) != 3){
    die "Invalid file name, not enough information";   
}

#set the output file name
my $dest = "$variables[0]_output\.pgm";

#open the targetted file
open(TEST, $file) or die "Can't open file \n";
binmode(TEST);	#binary mode

local $/; #slurp mode
my @data;
#set the mode according to the hilo or lohi
if($arr eq "hilo"){
	@data = unpack 's>*', <TEST>; #big endian
}else{
	@data = unpack 's<*', <TEST>; #small endian
}

close(TEST);

#open/create new file to write in
unless (open FILE, '>'.$dest) {
	die "unable to create $dest\n"
}

binmode(FILE);	#binary mode

my $length = @data;	#array length
#declare the header for pgm
print FILE "P5\n";
print FILE "$variables[2]\n";
print FILE "$variables[1]\n";
#check whether the one_byte toggled or not
if($one_byte == 1){
	print FILE "255\n";
	for(my $i = 0; $i < $length; $i++){
		#scale the value from 0 - 65535 to 0 - 255;
		my $scale = ceil(($data[$i]/65535) * 255);
		print FILE pack("S", $scale);
		#print "$scale\n";
	}
}else{
	print FILE "65535\n";
	for(my $i = 0; $i < $length; $i++){
		print FILE pack("S", $data[$i]);
	}
}




close(FILE);

#print $data;