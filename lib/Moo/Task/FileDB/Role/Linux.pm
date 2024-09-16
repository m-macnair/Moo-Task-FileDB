# ABSTRACT : Linux specific methods for fulfilling necessary actions - typically commandline
package Moo::Task::FileDB::Role::Linux;
our $VERSION = 'v0.0.13';
##~ DIGEST : 3e0c3feac3fef8fda89ccc21e0af8cc7
use Moo::Role;
use Carp qw(cluck confess);

#TODO host awareness?
sub get_md5_hash_string_for_file_string {
	my ( $self, $file_string, $p ) = @_;

	my $md5_string = `md5sum "$file_string"`;
	( $md5_string ) = split( /\s+/, $md5_string );
	return $md5_string;
}
1;
