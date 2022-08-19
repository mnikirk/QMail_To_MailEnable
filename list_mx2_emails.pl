#!/usr/bin/perl

# list_mx2_emails.pl
# MRN - 1/31/19

use strict;
use warnings;

my $report = "";

system('/home/vpopmail/domains/list_users_passwords >> pwd_dump.txt');
my $file = '/home/vpopmail/domains/pwd_dump.txt';
open(my $in_fh,$file) or die "Could not open file $file!!!!\n";
while (my $row = <$in_fh>) {
    chomp $row;
    if($row =~ m#^name:\s(.+)$#) {
        $report = $report . "$1,";
    }
    if($row =~ m#^clear passwd:\s(.+)$#) {
        $report = $report . "$1,";
    }
    if($row =~ m#/home/vpopmail/domains/((.+)\.\w{3})/#) {
        $report = $report . "$1\n";
    }
}
close $in_fh;
open(my $out_fh,'>','mx2_emailpass.txt') or die "Cannot open output file!!!!\n";
print $out_fh $report;
close $out_fh;
