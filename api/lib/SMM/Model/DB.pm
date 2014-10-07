package SMM::Model::DB;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'SMM::Schema',
    
    connect_info => {
        dsn => 'dbi:Pg:dbname=smm_db;host=localhost',
        user => 'postgres',
        password => '123mudar',
        quote_names => q{1},
    }
);

=head1 NAME

SMM::Model::DB - Catalyst DBIC Schema Model

=head1 SYNOPSIS

See L<SMM>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<SMM::Schema>

=head1 GENERATED BY

Catalyst::Helper::Model::DBIC::Schema - 0.63

=head1 AUTHOR

development

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;