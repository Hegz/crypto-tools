#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: Tabula_recta.pl
#
#        USAGE: ./Tabula_recta.pl [-p][-d] -k key -s string 
#
#  DESCRIPTION: An implementation of the Tabula_recta style cypher
#
#      OPTIONS: -k <string>       Key string to encode with
#               -s <string>       String to encode.
#               -p                Preserve whitespaces and punctuation.
#               -d                Decode the cypher, otherwise encode
#               -t                Enable Trithemius Mode, -k ignored.
#               -a                Autokey mode
#               -r                Print the Tabula Recta used as plain text
#
#       AUTHOR: Hegz
#      VERSION: 2.0
#      CREATED: 28/01/13 13:20:16
#===============================================================================

use strict;
use warnings;
use utf8;
use Getopt::Std;
my %opts;
getopts('s:k:pdta', \%opts);

# Table options can be adjusted here to include numbers, any characters.
my @alphabet = 'a' .. 'z';

# Build hash tables for faster encode/decode
my %alpha2seq;
my %seq2alpha;
for (0 .. (@alphabet - 1)) {
	$alpha2seq{$alphabet[$_]} = $_;
	$seq2alpha{$_} = $alphabet[$_];
}

if ($opts{'r'}) {
	#print the table, and exit
	show_table();
	exit 0;
}

unless ($opts{'p'}) {
	#Strip all punctuation and whitespace from the encode string
	$opts{'s'} =~ s/\s*//g;
	$opts{'s'} =~ s/[!?\/\\<>.,'"@()\[\]\-;]*//g;
}

my @message = split(//, lc($opts{'s'}));
my @key;
if ($opts{'t'}) {
	# Trithemius mode, The key is the same as the alphabet.
@key = @alphabet;
}
else {
	@key = split(//,lc($opts{'k'}));
}

my @out;
unless ($opts{'d'}) {
# Encode the message with the key
	if ($opts{'a'}) {
		push @key, @message;
	}
	my $key_count = 0;
	for (@message) {
		unless (defined $alpha2seq{$_}) {
			push @out, $_;
			next;
		}
		my $coded = $alpha2seq{$_} + $alpha2seq{$key[$key_count++]};
		if ($coded > (@alphabet -1 )){
			$coded -= @alphabet;
		}
		push @out, $seq2alpha{$coded};
		if (@key == $key_count){
			$key_count = 0;
		}
	}
}
else {
# Decode the message, with the key
	my $key_count = 0;
	for (@message) {
		unless (defined $alpha2seq{$_}) {
			push @out, $_;
			next;
		}
		my $coded = $alpha2seq{$_} - $alpha2seq{$key[$key_count++]};
		if ($coded < 0){
			$coded += @alphabet;
		}
		push @out, $seq2alpha{$coded};
		if ($opts{'a'}) {
			push @key, $seq2alpha{$coded};
		}
		if (@key == $key_count){
			$key_count = 0;
		}
	}
}

print @out;
print "\n";
exit 0;

sub show_table {
# Spit out a Tabula based on our language options.
	my $hsep = " ";
		print "  ";
		for (@alphabet){
			print uc($_) . $hsep;
		}
		print "\n";
	for (@alphabet) {
		print uc $alphabet[0] . $hsep;
		for (@alphabet){
			print $_ . $hsep;
		}
		print "\n";
			push @alphabet, shift @alphabet;
	}
}
