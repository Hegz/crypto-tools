#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: cypherplay.pl
#
#        USAGE: ./cypherplay.pl  
#
#  DESCRIPTION: A silly little key less cypher I had an idea for.
#               The idea being that the difference in place value between one
#               character and the next is the encoded character.  This is based
#               on a 0-25 indexed alphabet. eg:
#
#               helloworld = hxhadisdus
#
#               Original String:                     h e  l l o w o  r l  d
#               Place difference between characters: 7 23 7 0 3 8 18 3 20 18
#               Final Encode:                        h x  h a d i s  d u  s
#
#      OPTIONS: -s <string> The string to process
#               -d          decode flag.  Encode if not set.
#       AUTHOR: Hegz
#      VERSION: 2.0
#      CREATED: 28/01/13 10:18:28
#===============================================================================

use strict;
use warnings;
use utf8;
use Getopt::Std;

my %opts;
getopts('ds:', \%opts);

my @alpha = qw/a b c d e f g h i j k l m n o p q r s t u v w x y z/;

my $text = lc($opts{'s'});

my @result;

$text =~ s/ //g;
my @chars = split (//, $text);

my $last_char = undef;
my $current_char = undef;

if ($opts{'d'}) {
# Decode
	while ($current_char = shift @chars) {
		unless (defined $last_char) {
			$last_char = $current_char;
			push @result, $current_char;
		}
		else {
			my $pos=0;
			my $lpos=0;
			while ($alpha[$lpos] ne $last_char){
				$lpos++
			}
			while ($alpha[$pos] ne $current_char){
				$pos++;
			}
			my $rpos;
				$rpos = $lpos + $pos - @alpha;
			push @result, $alpha[$rpos];
			$last_char = $alpha[$rpos];
			}
	}
}
else {
# Encode portion of the code
	while ($current_char = shift @chars) {
		unless (defined $last_char) {
			$last_char = $current_char;
			push @result, $current_char;
		}
		else {
			my $pos=0;
			my $lpos=0;
			while ($alpha[$lpos] ne $last_char){
				$lpos++
			}
			while ($alpha[$pos] ne $current_char){
				$pos++;
			}
			my $rpos;
			if ($pos >= $lpos){
				$rpos = $pos  - $lpos;
			}
			else {
				$rpos = (@alpha - $lpos) + $pos;
			}
			push @result, $alpha[$rpos];
			$last_char = $current_char;
			}
	}
}

print @result;
print "\n";
exit 0;
