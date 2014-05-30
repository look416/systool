#!/usr/bin/perl
use strict;
use warnings;
use POSIX;

#validate the number of arguments
my $num_args = $#ARGV + 1;
if ($num_args != 2){
	print "\nUsage: threshold2pgm.pl file_name threshold_value\n";
	exit;
}

#do some validations on file name
#print $file;
my $file = $ARGV[0];
my @words = split '\.', $file;
#check the the file extension
if(! defined $words[1]){
	die "Invalid file type/extension";
}
#print $words[1];
chomp($words[1]);
if($words[1] ne "smg" && $words[1] ne "img" ){
	die "Invalid file type/extension";
}

my @variables = split'_', $words[0];

#check whether the filename consist of enough information
if((my $size = @variables) != 3){
    die "Invalid file name, not enough information";   
}

#validate the value of threshold_value
my $thres = $ARGV[1];
if($thres < 1 || $thres > 99){
	die "Invalid range number for threshold";	
}

open(TEST, $file) or die "Can't open file \n";
binmode(TEST);	#binary mode

local $/; #slurp mode
my @data;
@data = unpack 's>*', <TEST>; #big endian / hilo

close(TEST);

my $length = @data;	#array length

my $current_thres = 0; #current threshold
my $curval = 0;
my $counter;
if($words[1] eq "smg"){
	$curval = 65536;
}else{
	$curval = 255;
}
my $i;

while($current_thres < $thres){
	$counter = 0;
	for($i = 0; $i < $length; $i++){
		if($data[$i] >= $curval){
			$counter++;
		}
	}
	#print "Current threshold is $curval\n";
	if($words[1] eq "smg"){
		$curval = $curval - 655;
	}else{
		$curval = $curval - 25;
	}
	$current_thres = ($counter/$length) * 100;
	#print "Current threshold value is $current_thres\n";
}
# print "current thres is $current_thres and current value is $curval\n";

#set the output file name
my $dest = "$variables[0]_threshold_output\.pgm";

#open/create new file to write in
unless (open FILE, '>'.$dest) {
	die "unable to create $dest\n"
}

binmode(FILE);	#binary mode

#declare the header for pgm
print FILE "P5\n";
print FILE "$variables[2]\n";
print FILE "$variables[1]\n";
#check whether the one_byte toggled or not

print FILE "255\n";
for(my $i = 0; $i < $length; $i++){
	if($data[$i] > $curval){
		print FILE pack("S", 255);
	}else{
		print FILE pack("S", 0);
	}

}


close(FILE);


