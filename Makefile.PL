use ExtUtils::MakeMaker;
WriteMakefile(
    DISTNAME     => 'Filesys-getfsent',
    NAME         => 'Filesys::getfsent',
    VERSION_FROM => 'lib/Filesys/getfsent.pm',
    PREREQ_PM    => {},
    'dist'       => { COMPRESS => 'gzip', SUFFIX => 'gz' },
    ($] >= 5.005 ? 
       (ABSTRACT_FROM => 'lib/Filesys/getfsent.pm') : ()),
);
