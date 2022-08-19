#!/usr/bin/perl

# list_mx2_aliases.pl
# MRN - 1/25/19
# update 8-2022 to remove specific domain names

use strict;
use warnings;

my $report;
my @files = glob("/home/vpopmail/domains/!!DOMAIN!!/.qmail*");
# push @files, glob("/home/vpopmail/domains/!!DOMAIN!!/.qmail*");
# push @files, glob("/home/vpopmail/domains/!!DOMAIN!!/.qmail*");
# push @files, glob("/home/vpopmail/domains/!!DOMAIN!!/.qmail*");
# push @files, glob("/home/vpopmail/domains/!!DOMAIN!!/.qmail*");
# push @files, glob("/home/vpopmail/domains/!!DOMAIN!!/.qmail*");

foreach my $file (@files) {
    open(my $fh, $file) or die "Cannot open qmail file $file!!!!\n";
    $report = $report . "###############################################################\n";
    $report = $report . "$file\n";
    while (my $row = <$fh>) {
       chomp $row;
       $row =~ s/&//;
       $report  = $report . "\t$row\n";
    }
    close $fh;
}

open (my $fh,'>','qmail_aliases.txt') or die "Cannot open output file!!!!\n";
print $fh $report;
close $fh;
