package WWW::Mechanize::Link;

use strict;

=head1 NAME

WWW::Mechanize::Link - Link object for WWW::Mechanize

=head1 SYNOPSIS

Link object to encapsulate all the stuff that Mech needs but nobody
wants to deal with as an array.

=head1 Constructor

=head2 new()

 my $link = WWW::Mechanize::Link->new({
	url  => $url, 
	text => $text, 
	name => $name, 
	tag  => $tag,  
	base => $base,
	alt  => $alt,
 });

For compatibility, this older interface is also supported:

 new( $url, $text, $name, $tag, $base, $alt )

Creates and returns a new C<WWW::Mechanize::Link> object.

=cut

sub new {
    my $class = shift;

	# new style API
	my %p;
    my ($url,$text,$name,$tag,$base,$alt);
	if (ref $_[0] eq 'HASH') {
		%p =  %{ $_[0] }; 
		$url  = $p{url};
		$text = $p{text};
		$name = $p{name};
		$tag  = $p{tag};
		$base = $p{base};
		$alt  = $p{alt};
	}
	else {
		($url,$text,$name,$tag,$base,$alt) = @_; 

	}

    # The order of the first four must stay as they are for
    # compatibility with older code.
    my $self = [$url,$text,$name,$tag,$base,$alt];

    bless $self, $class;

    return $self;
}

=head1 Accessors

=head2 $link->url()

URL from the link

=head2 $link->text()

Text of the link

=head2 $link->name()

NAME attribute from the source tag, if any.

=head2 $link->tag()

Tag name (either "a", "frame" or "iframe").

=head2 $link->base()

Base URL to which the links are relative.

=head2 $link->alt()

Alt attribute contents. Useful for 'area' tags.

=cut

sub url  { return ($_[0])->[0]; }
sub text { return ($_[0])->[1]; }
sub name { return ($_[0])->[2]; }
sub tag  { return ($_[0])->[3]; }
sub base { return ($_[0])->[4]; }
sub alt  { return ($_[0])->[5]; }

=head2 $link->URI()

Returns the URL as a L<URI::URL> object.

=cut

sub URI {
    my $self = shift;

    require URI::URL;
    my $URI = URI::URL->new( $self->url, $self->base );

    return $URI;
}

=head2 $link->url_abs()

Returns the URL as an absolute URL string.

=cut

sub url_abs {
    my $self = shift;

    return $self->URI->abs;
}

=head1 Author

Copyright 2003 Andy Lester C<< <andy@petdance.com> >>

Released under the Artistic License.

=cut

1;
