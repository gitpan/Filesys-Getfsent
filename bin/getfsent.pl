#! /usr/bin/perl

use strict;
use warnings;
use Filesys::Getfsent qw(getfsent);

while (my @entry = getfsent()) {
    print "@entry\n";
}
