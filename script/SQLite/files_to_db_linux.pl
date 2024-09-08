#!/usr/bin/perl
# ABSTRACT:
our $VERSION = 'v0.0.4';

##~ DIGEST : 1c96eff789dba3801839cedc3c4a247f

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
	default => sub { return }
);

sub _do_db {
	my ( $self, $res ) = @_;
	$res ||= {};
	if ( $res->{db_file} ) {
		$self->sqlite3_file_to_dbh( $res->{db_file} );
	} else {
		my $db_path = './db/working_db.sqlite';

		unless ( -e $db_path ) {
			DBSETUP: {
				die( "DB Path [$db_path] could not be found" );
			}
			return 1;
		}
		$self->sqlite3_file_to_dbh( $db_path );
	}
}

sub process {
	my ( $self ) = @_;
	$self->_do_db( $self->config() );
	$self->sub_on_find_files(
		sub {
			my ( $full_path ) = @_;
			my $file_id = $self->get_file_id( $full_path );
			print "Fileid : $file_id, path : $full_path$/";
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
			},
			optional => {}
		}
	);
	$self->process();

}
