use 5.006;
use strict;
use warnings FATAL => 'all';
use inc::Module::Install;

name     'App-DevReactions';
all_from 'lib/App/DevReactions.pm';
author   q{Tobi Kremer <tobias@funkreich.de>};
license  'artistic2';

perl_version 5.006;

tests_recursive('t');

resources (
   #homepage   => 'http://yourwebsitehere.com',
   #IRC        => 'irc://irc.perl.org/#App-DevReactions',
   license    => 'http://www.perlfoundation.org/artistic_license_2_0',
   #repository => 'git://github.com/Tobi Kremer/App-DevReactions.git',
   bugtracker => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=App-DevReactions',
);

configure_requires (
   'Module::Install' => 0,
);

build_requires (
   'Test::More' => 0,
);

requires (
   #'ABC'              => 1.6,
   #'Foo::Bar::Module' => 5.0401,
);

install_as_cpan;
auto_install;
WriteAll;
