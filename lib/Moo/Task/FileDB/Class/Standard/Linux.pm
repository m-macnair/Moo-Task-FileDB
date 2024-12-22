# ABSTRACT : Role assembly for common Linux Use Case
package Moo::Task::FileDB::Class::Standard::Linux;
our $VERSION = 'v0.0.14';
##~ DIGEST : bc6430bf5525e10b10f7e0bf66bea0c5
use Moo;
with qw/

  Moo::GenericRole::DB
  Moo::GenericRole::DB::Abstract
  Moo::GenericRole::DB::SQLite

  Moo::Task::FileDB::Role::Core
  Moo::Task::FileDB::Role::Linux
  Moo::Task::FileDB::Role::DB::AbstractSQLite
  /;

sub _do_db {
	my ( $self, $p ) = @_;
	$p ||= {};
	if ( $p->{db_file} ) {
		$self->sqlite3_file_to_dbh( $p->{db_file} );
	} else {
		die "db_file not provided";
	}
}

1;
