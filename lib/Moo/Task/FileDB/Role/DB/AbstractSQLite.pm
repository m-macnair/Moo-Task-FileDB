
# ABSTRACT : Do DB Things using SQLite + SQL Abstract
package Moo::Task::FileDB::Role::DB::AbstractSQLite;
our $VERSION = 'v0.0.11';
##~ DIGEST : 682115a3c899c910521b20770f4b1c40
use Moo::Role;

#because I use confess everywhere
use Carp qw(cluck confess);

sub get_dir_id {
	my ( $self, $string, $host ) = @_;
	my $p = {name => $string};
	if ( $host ) {
		$p->{host} = $host;
	}
	my $row = $self->select_insert_href( 'dirs', $p, [qw/* /] );
	return $row->{id};
}

sub get_file_id {
	my ( $self, $string ) = @_;

	#TODO get URI host indicator
	my ( $file, $dir ) = $self->file_path_parts( $string );
	my $dir_id = $self->get_dir_id( $dir );

	my $p = {
		name   => $file,
		dir_id => $dir_id
	};
	my $row = $self->select_insert_href( 'files', $p, [qw/* /] );
	return $row->{id};
}

1;
