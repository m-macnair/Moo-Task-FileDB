#!/usr/bin/perl
# ABSTRACT:
our $VERSION = 'v0.0.8';

##~ DIGEST : a4848188e240c71d228c02b3e65c3834

use strict;
use warnings;

package Obj;
use Moo;
use parent qw/

  Moo::GenericRoleClass::CLI
  Moo::Task::FileDB::Class::Standard::Linux
  /;
has config => (
	is      => 'rw',
	lazy    => 1,
	default => sub { my $self = shift; $self->cfg(); }
);

sub process {
	my ( $self ) = @_;

	$self->sqlite3_file_to_dbh( $self->config()->{db_file} );
	my $sth = $self->query( "select id from file where hash_id is null;" );
	while ( my $row = $sth->fetchrow_arrayref() ) {
		my $path = $self->get_file_path_from_id( $row->[0] );
		my ( $hash_id, $res ) = $self->get_hash_id_for_file_string( $path );
		$self->update( 'file', {hash_id => $hash_id}, {id => $row->[0]} );
		print "$path : $hash_id [$res->{md5_string}]$/";
	}
}
1;

package main;

main();

sub main {
	my $self = Obj->new();
	$self->get_config(
		[
			qw/
			  db_file
			  /
		],
		[
			qw/
			/
		],
		{
			required => {
				db_file => "./working_db.sqlite in most cases",
			},
			optional => {}
		}
	);
	$self->process();

}
