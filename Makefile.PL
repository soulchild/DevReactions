use 5.008;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'App::DevReactions',
    AUTHOR           => q{Tobi Kremer <tobias@funkreich.de>},
    VERSION_FROM     => 'lib/App/DevReactions.pm',
    ABSTRACT_FROM    => 'lib/App/DevReactions.pm',
    LICENSE          => 'Artistic_2_0',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.008,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
    },
    PREREQ_PM => {
        'XML::Feed'         => 0,
        'Plack'             => 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'App-DevReactions-*' },
);
