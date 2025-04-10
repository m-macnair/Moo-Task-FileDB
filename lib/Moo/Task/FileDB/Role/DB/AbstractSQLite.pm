# ABSTRACT : Do DB Things using SQLite + SQL Abstract - this is the *only* sqlite module in MTFDB atm, but it relies on Moo/GenericRole/DB/SQLite.pm which is not included here for reasons
package Moo::Task::FileDB::Role::DB::AbstractSQLite;
our $VERSION = 'v1.1.2';
##~ DIGEST : a7012ee4de5cce270f2f5dc7011cf823
use Moo::Role;

#because I use confess everywhere
use Carp qw(cluck confess);

#nothing sqlite specific yet (?)
1;
