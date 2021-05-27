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

=head2 size

 my $size = $stat->size;

Returns the size of the file in bytes.

=cut

$ffi->attach( size => ['stat'] => 'off_t' );

1;


