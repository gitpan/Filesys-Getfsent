#! /usr/local/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

BEGIN {
    my $PACKAGE = 'Filesys::Getfsent';
    use_ok( $PACKAGE );
    require_ok( $PACKAGE );
}
