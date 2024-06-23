use 5.006;
use strict;
use warnings;
use Test::More;

use Test::Exception;

my $module = $1                                                  || 'Moo::Task::FileDB::Class::Standard::Linux';
use_ok( $module )                                                || BAIL_OUT "Failed to use $module : [$!]";
my $obj = $module->new( master_directory => "/tmp/FileDBTest", ) || BAIL_OUT "Failed to construct role user module : [$!]";

diag $obj->working_directory();
DBSETUP: {
	my $db_path = $obj->working_directory() . '/test.sqlite';
	open( my $fh, ">", $db_path );
	print $fh '';
	close( $fh );
	$obj->sqlite3_file_to_dbh( $db_path );
	$obj->init_db_schema();
}

CRITICALPATH: {
	$obj->get_file_id( '/home/m/stands.svg' );
}

done_testing();
