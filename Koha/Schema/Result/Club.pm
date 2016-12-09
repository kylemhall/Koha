use utf8;
package Koha::Schema::Result::Club;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Koha::Schema::Result::Club

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<clubs>

=cut

__PACKAGE__->table("clubs");

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

=head2 date_start

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 date_end

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 branchcode

  data_type: 'varchar'
  is_nullable: 1
  size: 11

=head2 date_created

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 date_updated

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  is_nullable: 1

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
  "date_start",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "date_end",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "branchcode",
  { data_type => "varchar", is_nullable => 1, size => 11 },
  "date_created",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "date_updated",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2016-12-09 12:13:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ojcQ+zx2lH7Yz/IULdG+Aw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
