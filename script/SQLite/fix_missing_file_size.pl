#!/usr/bin/perl
# ABSTRACT:
our $VERSION = 'v0.0.5';

##~ DIGEST : 71646cf72e6e46133348182e0872f9b9

use strict;
use warnings;

package Obj;
use Moo;
use parent qw/
  Moo::GenericRoleClass::CLI
  Moo::Task::FileDB::Class::Standard::Linux
  /; #provides  CLI, FileSystem, Common
with qw/
  Moo::GenericRole::DB
  Moo::GenericRole::DB::Abstract
  Moo::GenericRole::DB::SQLite
  Moo::Task::FileDB::Role::DB::SQLite::Setup
  Moo::Task::FileDB::Role::DB::AbstractSQLite

  /;
has config => (
	is      => 'rw',
	lazy    => 1,
	default => sub { return }
);

sub process {
	my ( $self ) = @_;
	$self->_do_db( $self->cfg() );
	my $sth = $self->query( "select * from file where size is null" );
	while ( my $row = $sth->fetchrow_hashref() ) {
		my $full_path = $self->get_file_path_from_id( $row->{id} );
		if ( -e $full_path ) {
			my $size = -s $full_path;
			$self->update( 'file', {size => $size}, {id => $row->{id}} );
			print "Updated [$row->{name}] with file_size [$size]$/";
		} else {
			warn "[$full_path] not found";
		}
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
