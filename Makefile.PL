use ExtUtils::MakeMaker;
WriteMakefile(
    DISTNAME     => 'Filesys-getfsent',
    NAME         => 'Filesys::getfsent',
    VERSION_FROM => 'lib/Filesys/getfsent.pm',
    PREREQ_PM    => { Exporter => 0 },
    'dist'       => { COMPRESS => 'gzip', SUFFIX => 'gz' },
    ($] >= 5.005 
      ? (ABSTRACT_FROM => 'lib/Filesys/getfsent.pm') : ()
    ),
);
