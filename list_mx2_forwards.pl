#!/usr/bin/perl

# list_mx_forwards.pl
# MRN - 1/25/19

use strict;
use warnings;

my $report;
my $cmd = "find . -type f -name '.qmail'";
my @files = `$cmd`;

foreach my $file (@files) {
    open(my $fh, $file);# or die "Cannot open qmail file $file!!!!\n";
    $report = $report . "###################################################\n";
    chomp $file;
    $report = $report . "$file\n";
    while (my $row = <$fh>) {
        chomp $row;
        $row =~ s/&//;
        $report = $report . "\t$row\n";
     }
     close $fh;
}

open (my $out_fh, '>', 'mx2_forwards.txt') or die "Cannot open output file!!!!\n";
print $out_fh $report;
print "Report output:\n";
print $report;
close $out_fh;
