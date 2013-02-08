=head1 PURPOSE

Checks lazy builders work with C<InsideOutAttribute>.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2012-2013 by Toby Inkster.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

BEGIN {
	package Local::Circle;
	no thanks;
	use Moose;
	use MooseX::FunkyAttributes;
	use constant _build_radius => 10;
	has radius => (
		traits     => [ InsideOutAttribute ],
		is         => 'rw',
		isa        => 'Num',
		lazy_build => 1,
	);
}

#######################################################################

use Test::More;

my $A = new_ok 'Local::Circle';
is($A->radius, 10, '$A->radius == 10');

#done_testing(); exit;

my $B = new_ok 'Local::Circle' => [ radius => 12 ];
is($B->radius, 12, '$B->radius == 12');

done_testing();
