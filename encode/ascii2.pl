#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: ascii2.pl
#
#        USAGE: ./ascii2.pl [-b | -o | -h |-6] <file>
#
#  DESCRIPTION: Convert Plain text ascii to a variety of encoding formats
#
#      OPTIONS: All Conversion options are exclusive
#               -b        Convert to Binary (base 2)
#               -o        Convert to Octal (base 8)
#               -d        Convert to Decimal (base 10)
#               -h        Convert to Hexadesimal (base 16)
#               -6        Convert to Base64 output (base duh.)
#
#        NOTES: If no output options are selected all formats printed
#       AUTHOR: Hegz
#      VERSION: 1.0
#      CREATED: 29/01/13 12:12:23
#===============================================================================

use strict;
use warnings;
use utf8;
use MIME::Base64;
use Getopt::Std;

my %opts;

getopts('bodh6', \%opts);

while (<>) {
	chomp;

	if ($opts{'b'}) {
		my @result = convert($_,'b');
		print "@result";
	}

	elsif ($opts{'o'}) {
		my @result = convert($_,'o');
		print "@result";

	}
	elsif ($opts{'d'}) {
		my @result = convert($_,'d');
		print "@result";
	}

	elsif ($opts{'h'}) {
		my @result = convert($_,'x');
		print "@result";
	}

	elsif ($opts{'6'}) {
		my $result = encode_base64($_);
		chomp $result;
		print $result;
	}
	else {
		my @result = convert($_,'b');
		print "Binary: @result\n" ;
		@result = convert($_,'o');
		print "Octal: @result\n";
		@result = convert($_,'d');
		print "Decimal: @result\n";
		@result = convert($_,'x');
		print "Hexidesimal: @result\n";
		my $result = encode_base64($_);
		chomp $result;
		print "Base64: $result";
	}
}

print "\n";
exit 0;


sub convert {
#===  FUNCTION  ================================================================
#         NAME: convert
#      PURPOSE: Convert ascii characters in astring to formats supported by 
#               sprintf. 
#   PARAMETERS: ($string, $format)
#      RETURNS: @conversion
#     COMMENTS: b, o, d, x for binary, octal, decimal, and hex.
#===============================================================================
	my @chars = split(//,shift);
	my $format = shift;
	my @result;
	for (@chars){
		my $bin = sprintf "%$format", ord;
		push @result, $bin;
	}
	return @result;
} ## --- end sub convert
