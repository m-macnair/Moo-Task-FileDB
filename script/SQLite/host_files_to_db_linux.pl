#!/usr/bin/perl
# ABSTRACT:
our $VERSION = 'v0.0.5';

##~ DIGEST : e093cab091bc28df72f20c077603f456

use strict;
use warnings;

package Obj;
use Moo;
use parent 'Moo::GenericRoleClass::CLI'; #provides  CLI, FileSystem, Common
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
	default => sub { my $self = shift; $self->cfg(); }
);

sub _do_db {
	my ( $self, $res ) = @_;
	$res ||= {};
	$self->sqlite3_file_to_dbh( $res->{db_file} );
}

sub process {
	my ( $self ) = @_;
	$self->_do_db( $self->cfg() );
	my $host_id = $self->get_host_id( $self->cfg()->{host} );
	$self->sub_on_find_files(
		sub {
			my ( $full_path ) = @_;
			my ( $host_file_id, $p ) = $self->get_host_file_id( $full_path, $self->cfg()->{host} );
			print "$full_path [$p->{file_id}] on host [$p->{host_id}] with host_file_id [$host_file_id]$/";

		},
		$self->cfg()->{path}
	);
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
			  path
			  host
			  /
		],
		[
			qw/
			/
		],
		{
			required => {
				db_file => "./working_db.sqlite in most cases",
				path    => "directory to process into the db",
				host    => "Host name string",
			},
			optional => {}
		}
	);
	$self->process();

}
