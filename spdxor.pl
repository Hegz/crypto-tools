#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: spdxor.pl
#
#        USAGE: ./spdxor.pl -i <infile> -o <outfile> -s <string>
#
#  DESCRIPTION: xors the contents of a file by a string.
#
#      OPTIONS: -i Input file
#               -o Output file
#               -s String
#
#      VERSION: 1.0
#      CREATED: 13-01-17 10:36:57 AM
#===============================================================================

use strict;
use warnings;
use Getopt::Std;

my %opts;
getopts('i:o:s:', \%opts);

open my $binfile, '<', $opts{'i'} or die $!;
binmode($binfile);

open my $outfile, '>', $opts{'o'} or die $!;
binmode $outfile;

my @string = map(ord, split(//, $opts{'s'}));

while (read ($binfile, my $input, scalar(@string))) {
	my @input = map(ord,split(//,$input));
	for (my $count =0; $count < scalar(@string); $count++) {
		next unless (defined($input[$count]));
		print $outfile chr($input[$count] ^ $string[$count]);
	}
}

close $binfile;
close $outfile;
