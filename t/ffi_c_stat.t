use Test2::V0 -no_srand => 1;
use FFI::C::Stat;
use File::stat;

my @props = qw(
  dev
  ino
  mode
  nlink
  uid
  gid
  rdev
  size
  mtime
  ctime
  blksize
  blocks
);

my $pstat = stat 'corpus/xx.txt';

is(
  FFI::C::Stat->new('corpus/xx.txt'),
  object {
    call [ isa => 'FFI::C::Stat' ] => T();
    call $_ => $pstat->$_ for @props;
    call atime => match qr/^[0-9]+$/;
  },
  'do a stat on a regular file',
);


{
  my $fh;
  open $fh, '<', 'corpus/xx.txt';
  my $pstat = stat $fh;
  is(
    FFI::C::Stat->new($fh),
    object {
      call [ isa => 'FFI::C::Stat' ] => T();
      call $_ => $pstat->$_ for @props;
      call atime => match qr/^[0-9]+$/;
    },
    'do a stat on a filehandle',
  );

  close $fh;
}


done_testing;
