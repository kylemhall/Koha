#!/usr/bin/perl

use Modern::Perl;

use List::MoreUtils 'any';

use Test::More tests => 25;

use t::lib::TestBuilder;

BEGIN {
    use FindBin;
    use lib $FindBin::Bin;
    use_ok('Koha::Library::Group');
    use_ok('Koha::Library::Groups');
}

our $dbh = C4::Context->dbh;
$dbh->{AutoCommit} = 0;
$dbh->{RaiseError} = 1;

$dbh->do(q|DELETE FROM issues|);

my $builder = t::lib::TestBuilder->new();

my $library1 = $builder->build(
    {
        source => 'Branch',
    }
);

my $library2 = $builder->build(
    {
        source => 'Branch',
    }
);

my $library3 = $builder->build(
    {
        source => 'Branch',
    }
);

my $root_group =
  Koha::Library::Group->new( { title => "Test root group" } )->store();

my @root_groups = Koha::Library::Groups->get_root_groups();
my $in_list = any { $_->id eq $root_group->id } @root_groups;
ok( $in_list, 'New root group is in the list returned by the get_root_groups method');

my $groupA  = Koha::Library::Group->new({ parent_id => $root_group->id, title => 'Group A' })->store();
my $groupA1 = Koha::Library::Group->new({ parent_id => $groupA->id,     title => 'Group A1' })->store();
my $groupA2 = Koha::Library::Group->new({ parent_id => $groupA->id,     title => 'Group A2' })->store();

my $groupA_library1  = Koha::Library::Group->new({ parent_id => $groupA->id,  branchcode => $library1->{branchcode} })->store();
my $groupA1_library2 = Koha::Library::Group->new({ parent_id => $groupA1->id, branchcode => $library2->{branchcode} })->store();

is( $groupA->is_in(  $library1->{branchcode} ), 1,   'Library 1 is in group A' );
is( $groupA->is_in(  $library2->{branchcode} ), 1,   'Library 2 is in group A' );
is( $groupA->is_in(  $library3->{branchcode} ), q{}, 'Library 3 is not in group A' );
is( $groupA1->is_in( $library1->{branchcode} ), q{}, 'Library 1 is not in group A1' );
is( $groupA1->is_in( $library2->{branchcode} ), 1,   'Library 2 is in group A1' );
is( $groupA1->is_in( $library3->{branchcode} ), q{}, 'Library 3 is not in group A1' );
is( $groupA2->is_in( $library1->{branchcode} ), q{}, 'Library 1 is not in group A2' );
is( $groupA2->is_in( $library2->{branchcode} ), q{}, 'Library 2 is not in group A2' );
is( $groupA2->is_in( $library3->{branchcode} ), q{}, 'Library 3 is not in group A2' );

is_deeply( [$groupA->libraries],  [ $library1->{branchcode}, $library2->{branchcode}], 'Group A libraries are correct' );
is_deeply( [$groupA1->libraries], [ $library2->{branchcode}],                          'Group A1 libraries are correct' );
is_deeply( [$groupA2->libraries], [],                                                  'Group A2 libraries are correct' );

my @children = $root_group->children()->as_list();
is( $children[0]->id, $groupA->id, 'Child of root group set correctly' );

@children = $groupA->children()->as_list();
is( $children[1]->id, $groupA1->id, 'Child 1 of 2nd level group set correctly' );
is( $children[2]->id, $groupA2->id, 'Child 2 of 2nd level group set correctly' );
is( $children[0]->id, $groupA_library1->id, 'Child 3 of 2nd level group set correctly' );

is( $children[0]->branchcode, $groupA_library1->branchcode, 'Child 3 is correctly set as leaf node' );

@children = $groupA1->children()->as_list();
is( $children[0]->branchcode, $library2->{branchcode}, 'Child 1 of 3rd level group correctly set as leaf node' );

my $library = $groupA_library1->library();
is( ref( $library ), 'Koha::Library', 'Method library returns a Koha::Library object' );
is( $library->id, $groupA_library1->branchcode, 'Branchcode for fetched library matches' );

my @libraries_not_direct_children = $groupA->libraries_not_direct_children();
$in_list = any { $_->id eq $groupA_library1->branchcode } @libraries_not_direct_children;
ok( !$in_list, 'Method libraries_not_direct_children returns all libraries not direct decendents of group, library 1 is not in the list');
$in_list = any { $_->id eq $groupA1_library2->branchcode } @libraries_not_direct_children;
ok( $in_list, 'Method libraries_not_direct_children returns all libraries not direct decendents of group, library 2 is in the list');
