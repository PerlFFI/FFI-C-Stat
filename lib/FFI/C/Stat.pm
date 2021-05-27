package FFI::C::Stat;

use strict;
use warnings;
use 5.008004;
use Ref::Util qw( is_ref is_globref);
use Carp ();
use FFI::Platypus 1.00;

# ABSTRACT: Object-oriented FFI interface to native stat and lstat
# VERSION

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut

my $ffi = FFI::Platypus->new( api => 1 );
$ffi->bundle;      # for accessors / constructor / destructor

$ffi->type('object(FFI::C::Stat)', 'stat');
if($^O eq 'MSWin32')
{
  $ffi->type('uint' => $_) for qw( uid_t gid_t nlink_t blksize_t blkcnt_t );
}

$ffi->mangler(sub { "stat__$_[0]" });

$ffi->attach( '_stat'  => ['string'] => 'opaque' );
$ffi->attach( '_fstat' => ['int',  ] => 'opaque' );
$ffi->attach( '_lstat' => ['string'] => 'opaque' );

=head1 CONSTRUCTOR

=head2 new

 my $stat = FFI::C::Stat->new(*HANDLE);
 my $stat = FFI::C::Stat->new($filename);

You can create a new instance of this class by calling the new method and passing in
either a file or directory handle, or by passing in the filename path.

=cut

sub new
{
  my($class, $file, %options) = @_;

  my $ptr;
  if(is_globref $file)
  { $ptr = _fstat(fileno($file)) }
  elsif(!is_ref($file) && defined $file)
  { $ptr = _stat($file) }
  else
  { Carp::croak("Tried to stat something whch is neither a glob reference nor a plain string") }

  bless \$ptr, $class;
}

$ffi->attach( DESTROY => ['stat'] );

=head1 PROPERTIES

=head2 dev

 my $id = $stat->dev;

The ID of device containing file.

=head2 ino

 my $inode = $stat->ino;

The inode number.

=head2 mode

 my $mode = $stat->mode;

The file type and mode.

=head2 nlink

 my $n = $stat->nlink;

The number of hard links.

=head2 uid

 my $uid = $stat->uid;

The User ID owner.

=head2 gid

 my $gid = $stat->gid;

The Group ID owner.

=head2 rdev

 my $id = $stat->rdev;

The ID of device (if special file)

=head2 size

 my $size = $stat->size;

Returns the size of the file in bytes.

=head2 atime

 my $time = $stat->atime;

The time of last access.

=head2 mtime

 my $time = $stat->mtime;

The time of last modification.

=head2 ctime

 my $time = $stat->ctime;

The time of last status change.

=head2 blksize

 my $size = $stat->blksize;

The filesystem-specific  preferred I/O block size.

=head2 blocks

 my $count = $stat->blocks;

Number of blocks allocated.

=cut

$ffi->attach( dev     => ['stat'] => 'dev_t'     );
$ffi->attach( ino     => ['stat'] => 'ino_t'     );
$ffi->attach( mode    => ['stat'] => 'mode_t'    );
$ffi->attach( nlink   => ['stat'] => 'nlink_t'   );
$ffi->attach( uid     => ['stat'] => 'uid_t'     );
$ffi->attach( gid     => ['stat'] => 'gid_t'     );
$ffi->attach( rdev    => ['stat'] => 'dev_t'     );
$ffi->attach( size    => ['stat'] => 'off_t'     );
$ffi->attach( atime   => ['stat'] => 'time_t'    );
$ffi->attach( mtime   => ['stat'] => 'time_t'    );
$ffi->attach( ctime   => ['stat'] => 'time_t'    );

if($^O ne 'MSWin32')
{
  $ffi->attach( blksize => ['stat'] => 'blksize_t' );
  $ffi->attach( blocks  => ['stat'] => 'blkcnt_t'  );
}
else
{
  *blksize = sub { '' };
  *blocks  = sub { '' };
}

1;


