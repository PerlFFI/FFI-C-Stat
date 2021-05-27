use Test2::V0 -no_srand => 1;
use FFI::C::Stat;
use File::stat;
use Config;

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

is(
  FFI::C::Stat->clone(FFI::C::Stat->new('corpus/xx.txt')),
  object {
    call [ isa => 'FFI::C::Stat' ] => T();
    call $_ => $pstat->$_ for @props;
    call atime => match qr/^[0-9]+$/;
  },
  'clone a stat',
);

{
  my $other = FFI::C::Stat->new('corpus/xx.txt');
  is(
    FFI::C::Stat->clone($$other),
    object {
      call [ isa => 'FFI::C::Stat' ] => T();
      call $_ => $pstat->$_ for @props;
      call atime => match qr/^[0-9]+$/;
    },
    'clone a from an opaque',
  );
}

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

unlink 'testlink';

if($Config{d_symlink} eq 'define')
{
  my $ret = eval { symlink 'corpus/xx.txt', 'testlink' };
  if($ret == 1)
  {
    my $pstat = lstat 'testlink';

    is(
      FFI::C::Stat->new('testlink', symlink => 1),
      object {
        call [ isa => 'FFI::C::Stat' ] => T();
        call $_ => $pstat->$_ for @props;
        call atime => match qr/^[0-9]+$/;
      },
      'do a stat on a symlink',
    );

  }
}

unlink 'testlink';

done_testing;
