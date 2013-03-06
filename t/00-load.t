#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'App::DevReactions' ) || print "Bail out!\n";
}

diag( "Testing App::DevReactions $App::DevReactions::VERSION, Perl $], $^X" );
