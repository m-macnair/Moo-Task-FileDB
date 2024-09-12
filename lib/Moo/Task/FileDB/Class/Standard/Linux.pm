# ABSTRACT : Role assembly for common Linux Use Case
package Moo::Task::FileDB::Class::Standard::Linux;
our $VERSION = 'v0.0.13';
##~ DIGEST : 289377a25a543f26dc88056998a45df9
use Moo;
with qw/

  Moo::GenericRole::DB
  Moo::GenericRole::DB::Abstract
  Moo::GenericRole::DB::SQLite
  Moo::GenericRole::DB::Working::AbstractSQLite

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
