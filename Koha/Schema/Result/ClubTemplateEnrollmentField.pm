use utf8;
package Koha::Schema::Result::ClubTemplateEnrollmentField;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Koha::Schema::Result::ClubTemplateEnrollmentField

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<club_template_enrollment_fields>

=cut

__PACKAGE__->table("club_template_enrollment_fields");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 club_template_id

  data_type: 'integer'
  is_nullable: 0

=head2 name

  data_type: 'tinytext'
  is_nullable: 0

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 authorised_value_category

  data_type: 'varchar'
  is_nullable: 1
  size: 16

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "club_template_id",
  { data_type => "integer", is_nullable => 0 },
  "name",
  { data_type => "tinytext", is_nullable => 0 },
  "description",
  { data_type => "text", is_nullable => 1 },
  "authorised_value_category",
  { data_type => "varchar", is_nullable => 1, size => 16 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2016-12-09 12:13:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:tDekPBsJsagC5Q5upYHdSQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
