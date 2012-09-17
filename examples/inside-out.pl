package Person;

use Moose;
use MooseX::FunkyAttributes;

has name => (
	traits => [ InsideOutAttribute ],
	is     => 'ro',
	isa    => 'Str',
);

has age => (
	is     => 'ro',
	isa    => 'Num',
);

package main;

use feature 'say';

my $bob = Person->new(name => 'Bob', age => 32);
say $bob->name;     # Bob
say $bob->dump;

