#!/usr/bin/perl
# ABSTRACT:
our $VERSION = 'v0.0.5';

##~ DIGEST : ab252f63af9870e866ba12b81d5c52c1

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
	my $sth = $self->query( "select * from file where file_type_id is null" );
	while ( my $row = $sth->fetchrow_hashref() ) {
		my ( undef, undef, $suffix ) = $self->file_parse( $row->{name} );

		#TODO: actual validation of the file type
		my $file_type_id = $self->get_file_type_id( lc( $suffix ) );
		$self->update( 'file', {file_type_id => $file_type_id}, {id => $row->{id}} );
		print "Updated [$row->{name}] with file_type_id [$file_type_id]$/";
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
