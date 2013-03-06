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
        'XML::Feed'         => 0,
        'Plack'             => 0,
    },
    PREREQ_PM => {
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'App-DevReactions-*' },
);
