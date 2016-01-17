package Koha::Library::Groups;

# Copyright ByWater Solutions 2016
#
# This file is part of Koha.
#
# Koha is free software; you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free Software
# Foundation; either version 3 of the License, or (at your option) any later
# version.
#
# Koha is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with Koha; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

use Modern::Perl;

use Carp;

use Koha::Database;

use Koha::Library::Group;

use base qw(Koha::Objects);

=head1 NAME

Koha::Library::Groups - Koha Library::Group object set class

=head1 API

=head2 Class Methods

=cut

=head3 my $tree_hashref = $self->get_tree()

=cut

sub get_tree {
    my ( $self ) = @_;

    my $root_group = $self->get_root_group();

    my $tree;

    $tree->{ $root_group->id }->{object} = $root_group;
    $tree->{ $root_group->id }->{children} = $root_group->_sub_tree( $root_group );

    return $tree;
}

=head3 my $tree_hashref = $self->_sub_tree()

=cut

sub _sub_tree {
    my ( $self, $parent ) = @_;

    my @children = $parent->children();

    my $subtree;

    foreach my $child ( @children ) {
        $subtree->{ $child->id }->{object} = $child;
        $subtree->{ $child->id }->{children} = $child->sub_tree($parent);
    }

    return $subtree;

}

=head3 my @root_groups = $self->get_root_group()

=cut

sub get_root_groups {
    my ( $self ) = @_;

    return $self->search( { parent_id => undef }, { order_by => 'title' } );
}

=head3 type

=cut

sub type {
    return 'LibraryGroup';
}

=head3 object_class

=cut

sub object_class {
    return 'Koha::Library::Group';
}

=head1 AUTHOR

Kyle M Hall <kyle@bywatersolutions.com>

=cut

1;
