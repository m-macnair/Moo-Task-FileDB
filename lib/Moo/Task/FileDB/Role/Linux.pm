# ABSTRACT : Linux specific methods for fulfilling necessary actions - typically commandline
package Moo::Task::FileDB::Role::Linux;
our $VERSION = 'v0.0.11';
##~ DIGEST : 3c7eb4d56fe43f33e96d6c3e696b73ea
use Moo::Role;
use Carp qw(cluck confess);

#TODO host awareness?
sub get_hash_id_for_file_string {
	my ( $self, $file_string, $p ) = @_;
	my ( $file_id, $file_row ) = $self->get_file_id( $file_string );

	if ( $file_row->{hash_id} && !$p->{force_hash} ) {
		return $file_row->{hash_id};
	}

	my $md5_string = `md5sum "$file_string"`;
	( $md5_string ) = split( /\s+/, $md5_string );
	$self->insert(
		'hash_string',
		{
			md5_string => $md5_string
		}
	);
	my $hash_id = $self->last_id();
	$self->update( 'file', {hash_id => $hash_id}, {id => $file_id} );
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

1;
