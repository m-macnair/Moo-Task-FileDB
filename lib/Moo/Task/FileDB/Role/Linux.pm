# ABSTRACT : Linux specific methods for fulfilling necessary actions - typically commandline
package Moo::Task::FileDB::Role::Linux;
our $VERSION = 'v0.0.12';
##~ DIGEST : 36ae45cc23bdd641fb33c7a1a848d819
use Moo::Role;
use Carp qw(cluck confess);

#TODO host awareness?
sub get_hash_for_file_string {
	my ( $self, $file_string, $p ) = @_;

	my $md5_string = `md5sum "$file_string"`;
	( $md5_string ) = split( /\s+/, $md5_string );
	return $md5_string;
}
1;
