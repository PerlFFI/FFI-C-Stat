use Test2::V0 -no_srand => 1;
use FFI::C::Stat;

is(
  FFI::C::Stat->new('corpus/xx.txt'),
  object {
    call [ isa => 'FFI::C::Stat' ] => T();
    call size => 3;
  },
  'do a stat on a regular file',
);


{
  my $fh;
  open $fh, '<', 'corpus/xx.txt';
  is(
    FFI::C::Stat->new($fh),
    object {
      call [ isa => 'FFI::C::Stat' ] => T();
      call size => 3;
    },
    'do a stat on a filehandle',
  );

  close $fh;
}




done_testing;
