# ABSTRACT : Role assembly for common Linux Use Case
package Moo::Task::FileDB::Class::Standard::Linux;
our $VERSION = 'v0.0.11';
##~ DIGEST : 15d4aa072503c2547d1733e298c1d880
use Moo;
with qw/
  Moo::Task::FileDB::Role::Core
  Moo::Task::FileDB::Role::Linux
  Moo::GenericRole::DB::Working::AbstractSQLite
  Moo::Task::FileDB::Role::DB::SQLite::Setup
  Moo::Task::FileDB::Role::DB::AbstractSQLite
  /;

1;
