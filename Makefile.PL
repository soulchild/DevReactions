use 5.008;
use strict;
use warnings FATAL => 'all';
use inc::Module::Install;

name     'App-DevReactions';
all_from 'lib/App/DevReactions.pm';
author   q{Tobi Kremer <tobias@funkreich.de>};
license  'artistic2';

perl_version 5.008;

# tests_recursive('t');

resources (
    homepage     => 'https://github.com/soulchild',
    repository   => 'https://github.com/soulchild/DevReactions.git',
    license      => 'http://www.perlfoundation.org/artistic_license_2_0',
);

configure_requires (
   'Module::Install' => 0,
);

build_requires (
    # 'Test::More' => 0,
);

requires (
    'XML::Feed'  => 0,
    'Plack'      => 0,
);

install_as_cpan;
auto_install;
WriteAll;
