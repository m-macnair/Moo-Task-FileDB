
# ABSTRACT : Do DB Things using SQLite + SQL Abstract
package Moo::Task::FileDB::Role::DB::AbstractSQLite;
our $VERSION = 'v0.0.13';
##~ DIGEST : f9e2c73c17af1dcc2cb88416f3d2ccdc
use Moo::Role;

#because I use confess everywhere
use Carp qw(cluck confess);

sub get_dir_id {
	my ( $self, $string, $host ) = @_;
	my $p = {name => $string};
	if ( $host ) {
		$p->{host} = $host;
	}
	my $row = $self->select_insert_href( 'dir', $p, [qw/* /] );
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
	my $row = $self->select_insert_href( 'file', $p, [qw/* /] );
	return $row->{id};
}

sub get_file_path {
	my ( $self, $id ) = @_;
	Carp::Confess( 'ID not provided' ) unless $id;
	my $file_row = $self->select( 'file', [qw/*/], {id => $id} )->fetchrow_hashref();
	Carp::Confess( 'File row not found' ) unless $file_row;
	my $dir_row = $self->select( 'dir', [qw/*/], {id => $file_row->{dir_id}} )->fetchrow_hashref();
	Carp::Confess( 'Dir row not found' ) unless $dir_row;
	my $path = "$dir_row->{name}$file_row->{name}";

	#not convinced this should be in this sub just yet
	#Carp::Confess("Path [$path] not found") unless $dir_row;
	return $path;

}
1;
