use utf8;
package Koha::Schema::Result::ClubEnrollmentField;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Koha::Schema::Result::ClubEnrollmentField

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<club_enrollment_fields>

=cut

__PACKAGE__->table("club_enrollment_fields");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 club_enrollment_id

  data_type: 'integer'
  is_nullable: 0

=head2 club_template_enrollment_field_id

  data_type: 'integer'
  is_nullable: 0

=head2 value

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "club_enrollment_id",
  { data_type => "integer", is_nullable => 0 },
  "club_template_enrollment_field_id",
  { data_type => "integer", is_nullable => 0 },
  "value",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2016-12-09 12:13:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:eEWwBOdDzzVTXAoScMyFXQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
