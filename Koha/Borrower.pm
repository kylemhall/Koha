package Koha::Borrower;

# Copyright ByWater Solutions 2014
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

use Koha::Clubs;
use Koha::Club::Enrollments;

use base qw(Koha::Object);

=head1 NAME

Koha::Borrower - Koha Borrower Object class

=head1 API

=head2 Class Methods

=cut

=head3 FirstValidEmailAddress

=cut

sub FirstValidEmailAddress {
    my ($self) = @_;

    return $self->email() || $self->emailpro() || $self->b_email() || q{};
}

=head3 GetClubEnrollments

=cut

sub GetClubEnrollments {
    my ($self) = @_;

    return Koha::Club::Enrollments->search( { borrowernumber => $self->borrowernumber(), date_canceled => undef } );
}

=head3 GetClubEnrollmentsCount

=cut

sub GetClubEnrollmentsCount {
    my ($self) = @_;

    my $e = $self->GetClubEnrollments();

    return $e->count();
}

=head3 GetEnrollableClubs

=cut

sub GetEnrollableClubs {
    my ( $self, $is_enrollable_from_opac ) = @_;

    my $params;
    $params->{is_enrollable_from_opac} = $is_enrollable_from_opac
      if $is_enrollable_from_opac;
    $params->{is_email_required} = 0 unless $self->FirstValidEmailAddress();

    $params->{borrower} = $self;

    return Koha::Clubs->GetEnrollable($params);
}

=head3 GetEnrollableClubsCount

=cut

sub GetEnrollableClubsCount {
    my ( $self, $is_enrollable_from_opac ) = @_;

    my $e = $self->GetEnrollableClubs($is_enrollable_from_opac);

    return $e->count();
}

=head3 type

=cut

sub type {
    return 'Borrower';
}

=head1 AUTHOR

Kyle M Hall <kyle@bywatersolutions.com>

=cut

1;
