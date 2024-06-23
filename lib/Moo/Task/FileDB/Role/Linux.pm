# ABSTRACT : Linux specific methods for fulfilling necessary actions - typically commandline
package Moo::Task::FileDB::Role::Linux;
our $VERSION = 'v0.0.10';
##~ DIGEST : 2e831312364e6682fa9a20ed7c4ef8d9
use Moo::Role;

#because I use confess everywhere
use Carp qw(cluck confess);

1;
