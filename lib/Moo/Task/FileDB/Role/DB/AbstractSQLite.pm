
# ABSTRACT : Do DB Things using SQLite + SQL Abstract
package Moo::Task::FileDB::Role::DB::AbstractSQLite;
our $VERSION = 'v0.0.10';
##~ DIGEST : 91d30a06a1325b45d8729612e433d8b0
use Moo::Role;

#because I use confess everywhere
use Carp qw(cluck confess);

sub get_dir_id {
	my ( $self, $string, $host ) = @_;
	my $p = {name => $string};
	if ( $host ) {
		$p->{host} = $host;
	}
	my $row = $self->select_insert_href( 'dirs', $p, [qw/* rowid/] );
	return $row->{rowid};
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
	my $row = $self->select_insert_href( 'files', $p, [qw/* rowid/] );
	return $row->{rowid};
}

1;
