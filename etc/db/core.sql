/* FileDB */
/* file */
CREATE TABLE file (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL,
	dir_id INTEGER,
	file_type_id INTEGER,
	/* one hash may legitimately belong to more than one file, e.g. duplicate files in the db */
	hash_id INTEGER,
	size INTEGER
);

CREATE INDEX file_name ON file(name);
CREATE INDEX file_dir_id ON file(dir_id);
CREATE INDEX file_file_type_id ON file(file_type_id);
CREATE INDEX file_hash_id ON file(hash_id);
CREATE INDEX file_size ON file(size);


/* file type */
CREATE TABLE file_type (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	suffix TEXT NOT NULL UNIQUE,
	mime_type TEXT NOT NULL
);

/* dir */
CREATE TABLE dir (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL
);
CREATE INDEX dir_name ON dir(name);

/* hash */ 
CREATE TABLE hash_string (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	md5_string TEXT,
	sha1_string TEXT
);
CREATE INDEX hash_string_md5_string ON hash_string(md5_string);
CREATE INDEX hash_string_sha1_string ON hash_string(sha1_string);

/* /FileDB */
