use ExtUtils::MakeMaker;
WriteMakefile(
    DISTNAME     => 'Filesys-Getfsent',
    NAME         => 'Filesys::Getfsent',
    VERSION_FROM => 'lib/Filesys/Getfsent.pm',
    PREREQ_PM    => { Exporter => 0 },
    ($] >= 5.005 
      ? (ABSTRACT_FROM => 'lib/Filesys/Getfsent.pm') : ()
    ),
);
