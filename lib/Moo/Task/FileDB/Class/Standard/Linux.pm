# ABSTRACT : Role assembly for common Linux Use Case
package Moo::Task::FileDB::Class::Standard::Linux;
our $VERSION = 'v0.0.10';
##~ DIGEST : 420135969228e4a6283437658b8002bf
use Moo;
with qw/
  Moo::Task::FileDB::Role::Core
  Moo::GenericRole::DB::Working::AbstractSQLite
  Moo::Task::FileDB::Role::DB::SQLite::Setup
  Moo::Task::FileDB::Role::DB::AbstractSQLite
  /;

1;
