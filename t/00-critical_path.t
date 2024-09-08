#!perl 
use 5.006;
use strict;
use warnings;
use Test::More;
use Test::Exception;
use File::Slurp;
use File::Copy;
use Data::Dumper;

my $test_id = time;
diag( "Using test id [$test_id]" );
my $module = $1   || 'Moo::Task::FileDB::Class::Standard::Linux';
use_ok( $module ) || BAIL_OUT "Failed to use $module : [$!]";
dies_ok( sub { new( $module ) } ); #passed a test earlier w/o db init

my $reference_db        = 'etc/db/test_db.sqlite';
my $test_directory_root = 'tmp_test/';
unless ( -d $test_directory_root ) {
	mkdir( $test_directory_root ) || BAIL_OUT "Failed to create absent test temp root directory [$test_directory_root] : [$!]";
}

my $this_test_directory = $test_directory_root . $test_id . '/';

unless ( -d $this_test_directory ) {
	mkdir( $this_test_directory ) || BAIL_OUT "Failed to create test temp directory [$this_test_directory] : [$!]";
}
my $test_db = "$this_test_directory/test_db.sqlite";
copy( $reference_db, $test_db ) || BAIL_OUT "Failed to copy test sql file to  [$this_test_directory] : [$!]";

my $self;

$self = new_ok( $module, [ {db_file => $test_db} ] );
$self->sqlite3_file_to_dbh( $test_db );
BASIC: {
	my $res = $self->get_file_id( 't/00-critical_path.t' );
	is( $res, 1, 'simple hash file' );

}

HASH: {
	my $res = $self->get_hash_id_for_file_string( 'LICENSE' );
	is( $res, 1, 'simple hash file' );
}
done_testing();
