BEGIN {
	package Local::Circle;
	no thanks;
	use Moose;
	use MooseX::FunkyAttributes;
	use constant PI => 3.14159; 
	has radius => (
		is         => 'rw',
		isa        => 'Num',
	);
	has diameter => (
		traits     => [ FunkyAttribute ],
		is         => 'rw',
		isa        => 'Num',
		custom_set => sub { $_[1]->radius($_[2] / 2) },
		custom_get => sub { 2 * $_[1]->radius },
		custom_has => sub { 1 },
	);
	has circumference => (
		traits     => [ FunkyAttribute ],
		is         => 'rw',
		isa        => 'Num',
		custom_set => sub { $_[1]->diameter($_[2] / PI) },
		custom_get => sub { PI * $_[1]->diameter },
		custom_has => sub { 1 },
	);
	has area => (
		traits     => [ FunkyAttribute ],
		is         => 'rw',
		isa        => 'Num',
		custom_set => sub { $_[1]->radius( sqrt($_[2]/PI) ) },
		custom_get => sub { PI * ( $_[1]->radius ** 2 ) },
		custom_has => sub { 1 },
	);
}

#######################################################################

use Test::More tests => 18;
use Test::Fatal;

my $circle1 = new_ok 'Local::Circle' => [ radius => 10 ];

is($circle1->radius,            10, '$circle1->radius');
is($circle1->diameter,          20, '$circle1->diameter');
is(int $circle1->circumference, 62, '$circle1->circumference');
is(int $circle1->area,         314, '$circle1->area');

$circle1->diameter(100); # bigger

is($circle1->radius,             50, '$circle1->radius');
is($circle1->diameter,          100, '$circle1->diameter');
is(int $circle1->circumference, 314, '$circle1->circumference');
is(int $circle1->area,         7853, '$circle1->area');

my $circle2 = new_ok 'Local::Circle' => [ circumference => 100 ];

is(int $circle2->radius,         15, '$circle2->radius');
is(int $circle2->diameter,       31, '$circle2->diameter');
is(int $circle2->circumference, 100, '$circle2->circumference');
is(int $circle2->area,          795, '$circle2->area');

foreach my $attr (qw( radius diameter circumference area ))
{
	like(
		exception { $circle2->$attr("Foo") },
		qr{Validation failed for 'Num'},
		qq{Type constraint for $attr still enforced},
	);
}
