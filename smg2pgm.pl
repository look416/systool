#!/usr/bin/perl
use strict;
use warnings;

my $one_byte = 0;
my $arr = "hilo";

#do validations on command line arguments
#validate the number of arguments
my $num_args = $#ARGV + 1;
if ($num_args != 1 && $num_args != 2 && $num_args != 0){
	print "\nUsage: smg2pgm.pl [lohi/hilo] [one_byte]\n";
	exit;
}

#validate the options when num args is 1
if($num_args == 1){
	my $arg1 = $ARGV[0];
	if($arg1 ne "lohi" && $arg1 ne "hilo" && $arg1 ne "one_byte"){
		print "\nUsage: smg2pgm.pl [lohi/hilo] [one_byte]\n";
		exit;
	}
	if($arg1 eq "lohi"){
		$arr = "lohi";
	}elsif($arg1 eq "one_byte"){
		$one_byte = 1;
	}
}

#validate the options when num args is 2
if($num_args == 2){
	my $arg1 = $ARGV[0];
	my $arg2 = $ARGV[1];
	#print "$arg1\n";
	if($arg1 ne "lohi" && $arg1 ne "hilo" || $arg2 ne "one_byte"){
		print "\nUsage: smg2pgm.pl [lohi/hilo] [one_byte]\n";
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

#user input the file name
print "Please enter the smg file name: \n";
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
if($words[1] ne "smg"){
	die "Invalid file type/extension";
}

my @variables = split'_', $words[0];

open(TEST, $file) or die "Can't open file \n";

binmode(TEST);

my $data = <TEST>;

close(TEST);

print $data;