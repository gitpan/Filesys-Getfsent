#! /usr/local/bin/perl

use strict;
use warnings;
use Filesys::getfsent qw(getfsent);

while (my @entry = getfsent()) {
    print "@entry\n";
}
