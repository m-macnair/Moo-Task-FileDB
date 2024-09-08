# ABSTRACT : Role assembly for common Linux Use Case
package Moo::Task::FileDB::Class::Standard::Linux;
our $VERSION = 'v0.0.12';
##~ DIGEST : 8cc4e5ccf2afa5672dfe34a731cfb39e
use Moo;
with qw/

  Moo::GenericRole::DB
  Moo::GenericRole::DB::Abstract
  Moo::GenericRole::DB::SQLite
  Moo::GenericRole::DB::Working::AbstractSQLite

  Moo::Task::FileDB::Role::Core
  Moo::Task::FileDB::Role::Linux
  Moo::Task::FileDB::Role::DB::AbstractSQLite
  /;

1;
