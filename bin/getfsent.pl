#!/usr/local/bin/perl

use strict;
use warnings;
use Filesys::getfsent;

while (my @entry = getfsent()) {
    print "@entry\n";
}
