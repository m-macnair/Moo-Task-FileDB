# ABSTRACT : Foundation role for FileDB
package Moo::Task::FileDB::Role::Core;
our $VERSION = 'v0.0.10';
##~ DIGEST : 61dd8b39e44892a159db98fef1dd8eeb
use Moo::Role;
with qw/
  Moo::GenericRole::FileSystem
  Moo::GenericRole::FileSystem::WorkingDirectory
  /;

#because I use confess everywhere
use Carp qw(cluck confess);

1;
