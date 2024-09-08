/* FileDB - Host Addon*/
/* host */
CREATE TABLE host (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL
);
CREATE INDEX host_name ON host(name);

/* host_file*/
CREATE TABLE host_file (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	file_id INTEGER,
	host_id INTEGER
);
CREATE INDEX host_file_file_id ON host_file(file_id);
CREATE INDEX host_file_host_id ON host_file(host_id);

/* I'm still not convinced about this - on t'one hand, solve processing through storage, on t'other, maintenance */
CREATE TABLE host_dir_substitution (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	original_id INTEGER,
	alternate_id INTEGER
);
CREATE INDEX host_dir_substitution_original_id ON host_dir_substitution(original_id);
CREATE INDEX host_dir_substitution_alternate_id ON host_dir_substitution(alternate_id);


/* /FileDB */
