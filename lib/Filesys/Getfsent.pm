package Filesys::Getfsent;

$VERSION = '0.09';
@EXPORT_OK = qw(getfsent);

use strict 'vars';
use vars qw($ENTRIES $FSTAB);
use base qw(Exporter);
use Carp 'croak';
use FileHandle;


$ENTRIES = __PACKAGE__.'::_fsents';
$FSTAB = '/etc/fstab';


sub getfsent {   
    if (wantarray) {
        unless (${$ENTRIES}) {
            @{$ENTRIES} = @{_parse_entries()};
            ${$ENTRIES} = 1;
        }
	 
        if (@{$ENTRIES}) {
	    return @{shift @{$ENTRIES}};
	}
	else { 
	    ${$ENTRIES} = 0;
	    
	    return (); 
	}
    }
    else { return _count_entries() }
}

sub _parse_entries {
    my @entries;
    
    my $fh = _open_fh();
    
    for (my $i = 0; local $_ = <$fh>; $i++) {
        chomp;
	my @entry = split;
	
	if ($entry[3] !~ /,/) {                       # In case element 4, fs_type, doesn't
	    splice( @entry, 3, 1, '', $entry[3] );    # contain fs_mntops, insert blank fs_mntops     
	}                                             # at index 3 and move fs_type to index 4.
	else {          
	    splice( @entry, 3, 1,                     # In case element 4 contains fs_type and
	      (reverse split ',', $entry[3], 2) );    # fs_mntops, switch fs_mntops to index 3 and 
	}                                             # fs_type to index 4.	
	
	@{$entries[$i]} = @entry;
    }
    
    _close_fh( $fh );
    
    return \@entries;
}

sub _count_entries {
    my $counted_entries;
    
    my $fh = _open_fh();   
    $counted_entries++ while <$fh>;
    _close_fh( $fh ); 
    
    return $counted_entries;
}    

sub _open_fh {
    my $fh = new FileHandle $FSTAB, 'r'
      or croak "Couldn't open $FSTAB: $!";
      
    return $fh;
}

sub _close_fh { 
    my ($fh) = @_;
    $fh->close;
}

1;
__END__

=head1 NAME

Filesys::Getfsent - Get file system entries

=head1 SYNOPSIS

 use Filesys::Getfsent qw(getfsent);

 while (@entry = getfsent()) {
    print "@entry\n";
 }

=head1 DESCRIPTION

C<getfsent()> is an implementation of the according
BSD function. Returns in array context each file 
system entry.      

 $entry[0]    # block special device name 
 $entry[1]    # file system path prefix
 $entry[2]    # type of file system
 $entry[3]    # comma separated mount options
 $entry[4]    # rw, ro, sw, or xx
 $entry[5]    # dump frequency, in days 
 $entry[6]    # pass number on parallel fsck

In scalar context, total of entries is returned.

=head1 EXPORT

C<getfsent()> is exportable.

=head1 SEE ALSO

fstab(5), getfsent(3) 

=cut
