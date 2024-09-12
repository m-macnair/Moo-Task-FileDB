# ABSTRACT : Do DB Things using SQLite + SQL Abstract - this is the *only* sqlite module in MTFDB atm, but it relies on Moo/GenericRole/DB/SQLite.pm which is not included here for reasons
package Moo::Task::FileDB::Role::DB::AbstractSQLite;
our $VERSION = 'v0.0.18';
##~ DIGEST : a5ec7e444ff1b21d66f0d174e784f2dc
use Moo::Role;

#because I use confess everywhere
use Carp qw(cluck confess);

sub get_dir_id {
	my ( $self, $string ) = @_;
	my $p   = {name => $string};
	my $row = $self->select_insert_href( 'dir', $p, [qw/* /] );
	return $row->{id};
}

#TODO - handle
sub get_file_id {
	my ( $self, $string ) = @_;

	#TODO get URI host indicator (?)
	my ( $file, $dir ) = $self->file_path_parts( $string );
	my ( undef, undef, $suffix ) = $self->file_parse( $string );

	#TODO: actual validation of the file type
	my $file_type_id = $self->get_file_type_id( lc( $suffix ) );
	my $dir_id       = $self->get_dir_id( $dir );

	my $p = {
		name         => $file,
		dir_id       => $dir_id,
		file_type_id => $file_type_id
	};
	my $row = $self->select_insert_href( 'file', $p, [qw/* /] );
	if ( wantarray() ) {
		return ( $row->{id}, $row );
	} else {
		return $row->{id};
	}
}

sub get_hash_id_for_file_string {
	my ( $self, $file_string, $p ) = @_;
	my ( $file_id, $file_row ) = $self->get_file_id( $file_string );

	if ( $file_row->{hash_id} && !$p->{force_hash} ) {
		return $file_row->{hash_id};
	}
	my $md5_string = $self->get_md5_hash_string_for_file_string( $file_string );

	$self->insert(
		'hash_string',
		{
			md5_string => $md5_string
		}
	);
	my $hash_id = $self->last_id();

	if ( wantarray() ) {
		return (
			$hash_id,
			{
				md5_string => $md5_string
			}
		);
	} else {
		return $hash_id;
	}

}

sub get_file_type_id {
	my ( $self, $string ) = @_;
	return $self->select_insert_string_id( $string, 'file_type', {string_column => 'suffix'} );

}

sub get_file_path_from_id {
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

sub get_host_id {
	my ( $self, $string ) = @_;
	my $p   = {name => $string};
	my $row = $self->select_insert_href( 'host', $p, [qw/*/] );
	return $row->{id};
}

sub get_host_file_id {
	my ( $self, $file, $host ) = @_;
	my $p = {
		file_id => $self->get_file_id( $file ),
		host_id => $self->get_host_id( $host ),
	};
	my $row = $self->select_insert_href( 'host_file', $p, [qw/* /] );
	if ( wantarray() ) {
		return ( $row->{id}, $row );
	} else {
		return $row->{id};
	}
}

1;
