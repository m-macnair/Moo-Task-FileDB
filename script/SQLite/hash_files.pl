#!/usr/bin/perl
# ABSTRACT:
our $VERSION = 'v0.0.6';

##~ DIGEST : 568d3eabf9c6b0d7d7c26ce5f4cef41d

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
