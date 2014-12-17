use utf8;
package SMM::Schema::Result::Region;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::Region

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=item * L<DBIx::Class::PassphraseColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "PassphraseColumn");

=head1 TABLE: C<region>

=cut

__PACKAGE__->table("region");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'region_id_seq'

=head2 geom

  data_type: 'geometry'
  is_nullable: 1

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 lat

  data_type: 'text'
  is_nullable: 1

=head2 long

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "region_id_seq",
  },
  "geom",
  { data_type => "geometry", is_nullable => 1 },
  "name",
  { data_type => "text", is_nullable => 1 },
  "lat",
  { data_type => "text", is_nullable => 1 },
  "long",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07041 @ 2014-12-16 09:32:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:LSUurwAh/2LYzm6eGzBViA


with 'SMM::Role::Verification';
with 'SMM::Role::Verification::TransactionalActions::DBIC';
with 'SMM::Schema::Role::ResultsetFind';

use Data::Verifier;
use MooseX::Types::Email qw/EmailAddress/;
use SMM::Types qw /DataStr TimeStr/;

sub verifiers_specs {
    my $self = shift;
    return {
        update => Data::Verifier->new(
            filters => [qw(trim)],
            profile => {
                name => {
                    required => 0,
                    type     => 'Str',
                },
                geom => {
                    required => 0,
                    type     => 'Str',
                },
                lat => {
                    required => 0,
                    type     => 'Str',
                },
                long => {
                    required => 0,
                    type     => 'Str',
                },
            }
        ),
    };
}

sub action_specs {
    my $self = shift;
    return {
        update => sub {
            my %values = shift->valid_values;

            not defined $values{$_} and delete $values{$_} for keys %values;

            my $region = $self->update( \%values );

            return $region;
		}
	}
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
