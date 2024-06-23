
# ABSTRACT : Methods for setting up $the_db in SQLite
package Moo::Task::FileDB::Role::DB::SQLite::Setup;
our $VERSION = 'v0.0.11';
##~ DIGEST : f5b97a39ea36abd69f00a3602013e196
use Moo::Role;

#because I use confess everywhere
use Carp qw(cluck confess);

sub init_db_schema {
	my ( $self, $dbh ) = @_;
	$dbh ||= $self->dbh();
	my $sql = <<'SQL';

	CREATE TABLE file_types (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		suffix TEXT NOT NULL UNIQUE,
		mime_type TEXT NOT NULL
	);
	CREATE INDEX file_types_suffix ON file_types(suffix);
	CREATE INDEX file_types_mime_type ON file_types(mime_type);

	CREATE TABLE dirs (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		name TEXT NOT NULL,
		host TEXT
	);
	CREATE INDEX dirs_name ON dirs(name);
	CREATE INDEX dirs_host ON dirs(host);


	CREATE TABLE hashes (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		file_id INTEGER,
		hashed BOOLEAN CHECK (hashed IN (0, 1)),
		md5_string TEXT,
		sha1_string TEXT
	);
	CREATE INDEX hashes_file_id ON hashes(file_id);
	CREATE INDEX hashes_md5_string ON hashes(md5_string);
	CREATE INDEX hashes_sha1_string ON hashes(sha1_string);

	CREATE TABLE files (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		name TEXT NOT NULL,
		dir_id INTEGER,
		file_type_id INTEGER,
		hash_id INTEGER,
		size INTEGER
	);
	CREATE INDEX files_name ON files(name);
	CREATE INDEX files_dir_id ON files(dir_id);
	CREATE INDEX files_file_type_id ON files(file_type_id);
	CREATE INDEX files_hash_id ON files(hash_id);
	CREATE INDEX files_size ON files(size);

SQL
	for my $st ( split( /;/, $sql ) ) {
		$dbh->do( $st ) or die $!;
	}
}
1;
