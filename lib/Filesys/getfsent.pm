package Filesys::getfsent;

$VERSION = '0.02';
@EXPORT = qw(getfsent);

use strict 'vars';
use vars qw($ENTRIES $FSTAB);
use base qw(Exporter);
use Carp 'croak';
use FileHandle;

$ENTRIES = __PACKAGE__.'::fsents';
$FSTAB = '/etc/fstab';

sub getfsent {   
    if (wantarray) {
        unless (${$ENTRIES}) {
            @{$ENTRIES} = @{_parse_entries()};
            ${$ENTRIES} = 1;
        } 
        if (@{$ENTRIES}) {
            my @entry = @{${$ENTRIES}[0]};
	    shift @{$ENTRIES};
            return @entry;
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
	# In case element 4, fs_type, doesn't
	# contain fs_mntops, insert blank fs_mntops
	# at index 3 and move fs_type to index 4. 
	if ($entry[3] !~ /,/) {
	   splice(@entry, 3, 1, '', $entry[3]);
	}
	# In case element 4 contains fs_type and 
	# fs_mntops, switch fs_mntops to index 3 and
	# fs_type to index 4.
	else { 
	    splice(@entry, 3, 1, (reverse split ',', $entry[3], 2)); 
	}
	@{$entries[$i]} = @entry;
    }
    _close_fh($fh);
    return \@entries;
}

sub _count_entries {
    my $counted_entries;
    my $fh = _open_fh();   
    $counted_entries++ while <$fh>;
    _close_fh($fh); 
    return $counted_entries;
}    

sub _open_fh {
    my $fh = new FileHandle "$FSTAB", 'r'
      or croak "Couldn't open $FSTAB: $!";
    return $fh;
}

sub _close_fh { 
    my $fh = shift;
    $fh->close;
}

1;
__END__

=head1 NAME

Filesys::getfsent - Get file system entries

=head1 SYNOPSIS

 use Filesys::getfsent;

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

C<getfsent()> by default.

=head1 SEE ALSO

fstab(5), getfsent(3) 

=cut
