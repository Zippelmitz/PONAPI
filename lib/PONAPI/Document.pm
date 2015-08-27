package PONAPI::Document;
# ABSTRACT: A Perl implementation of the JASON-API (http://jsonapi.org/format) spec - Document

use strict;
use warnings;
use Moose;

has is_collection_req => (
    is       => 'ro',
    isa      => 'Bool',
    required => 1,
);

has data => (
    is        => 'ro',
    isa       => 'ArrayRef[PONAPI::Resource]',
    predicate => 'has_data',
);

has errors => (
    is        => 'ro',
    isa       => 'PONAPI::Error',
    predicate => 'has_error',
);

has links => (
    is        => 'ro',
    isa       => 'PONAPI::Links',
    predicate => 'has_links',
);

has included => (
    is        => 'ro',
    isa       => 'ArrayRef[PONAPI::Resource]',
    predicate => 'has_included',
);

has meta => (
    is      => 'ro',
    isa     => 'HashRef',
    default => +{},
);

has jsonapi => (
    is      => 'ro',
    isa     => 'HashRef',
    default => +{},
);


sub pack {
    my $self = shift;
    my %ret;

    # add either errors or data
    if ( $self->has_errors ) {
        $ret{errors} = $self->errors;

    } else {
        $ret{data} = $self->has_data
            ? ( $self->is_collection_req ? $self->data : $self->data->[0] )
            : ( $self->is_collection_req ? [] : undef );

        $self->has_included and $ret{included} = $self->included;
    }

    keys %{ $self->meta } and $ret{meta} = $self->meta;

    # TODO: check: document must have at least one of: data, errors, meta

    $self->has_links and $ret{links} = $self->links;

    keys %{ $self->jsonapi } and $ret{jsonapi} = $self->jsonapi;

    return \%ret;
}


__PACKAGE__->meta->make_immutable;
1;

__END__

=head1 SYNOPSIS



=head1 DESCRIPTION



=head1 ATTRIBUTES

=head2 data



=head2 erorrs



=head2 meta



=head2 jsonapi



=head2 links



=head2 included

