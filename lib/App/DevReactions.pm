package App::DevReactions;

use utf8;
use strict;
use warnings;

use URI;
use Encode;
use XML::Feed;

our $VERSION = "0.01";

=head1 NAME

App::DevReactions - Watch dev reactions animated GIFs in fullscreen

=head1 VERSION

Version 0.01

=cut

my $feeds = [
    {
        name        => 'DevOps Reactions',
        url         => 'http://devopsreactions.tumblr.com',
        feed_url    => 'http://devopsreactions.tumblr.com/rss',
        regex       => qr|<img.*src="(http://.+?)"|,
    },
    {
        name        => 'Security Reactions',
        url         => 'http://securityreactions.tumblr.com',
        feed_url    => 'http://securityreactions.tumblr.com/rss',
        regex       => qr|<img.*src="(http://.+?)"|,
    },
    {
        name        => 'TheCodingLove',
        url         => 'http://thecodinglove.com',
        feed_url    => 'http://thecodinglove.com/rss',
        regex       => qr|<img.*src="(http://.+?)"|,
    },
];

=head1 DESCRIPTION

Love the animated GIFs from sites like devopsreactions and thecodinglove? 

This app lets you view them in full screen mode in your browser.

=cut

sub load_reactions {
    my $feed_id = 0;

    my @reactions = ();
    for my $feed( @{ $feeds } ) {
        my $f = XML::Feed->parse( URI->new( $feed->{ 'feed_url' } ) ) 
            or die sprintf( "Couldn't parse feed %s: %s", $feed->{ 'name' }, $@ );

        for my $entry( $f->entries ) {
            if( my $content = $entry->content ) {
                if( my $body = $content->body ) {
                    if( my( $image_url ) = ( $body =~ $feed->{ 'regex' } ) ) {
                        push @reactions, { 
                            feed_id     => $feed_id, 
                            title       => $entry->title, 
                            image       => $image_url,
                            url         => $entry->link,
                        };
                    }
                }
            }
        }

        $feed_id++;
    }

    return \@reactions;
}

my $requests    = 0;
my $reactions   = [];

sub app {
    return sub {
        my $env = shift;

        # 404 for all requests other than /
        if( $env->{ REQUEST_URI } !~ /^\/$/ ) {
            return [ 404, [], [] ];
        }

        # Reload feeds every 100 requests
        $reactions = load_reactions() if $requests++ % 100 == 0;

        # Grab next random reaction
        my $reaction_total  = scalar @$reactions;
        my $no              = int( rand( $reaction_total ) );
        my $reaction        = $reactions->[ $no ];
        my $reaction_url    = $reaction->{ 'url' };
        my $reaction_no     = $no + 1;
        my $reaction_title  = $reaction->{ 'title' };
        my $reaction_feed   = $feeds->[ $reaction->{ 'feed_id' } ]->{ 'name' };
        my $reaction_image  = $reaction->{ 'image' };

        my $body = <<EOF;
<!doctype html>
<html>
    <head>
        <title>DevReactions</title>
        <style type="text/css">
            body {
                margin:auto; 
                background:#000; 
                font-family:Helvetica, Arial, sans-serif; 
                color:white;
                font-smoothing: antialiased;
                -webkit-font-smoothing: antialiased;
                text-rendering: optimizeLegibility;
                overflow:hidden;
            }
            header {
                position:absolute; 
                margin:0; 
                background:rgba(0,0,0,.6); 
                padding:12px 16px; 
                top:0; 
                left:0;
            }
            h1, h2 {
                margin:0;
            }
            h2 {
                font-weight:normal;
            }
            article img {
                border:none;
                height:100%;
                min-height:100%;
                max-width:100%;
            }
            a, a:link, a:visited, a:hover {
                color:white;
                text-decoration:none;
            }
        </style>
        <meta http-equiv="refresh" content="15; URL=/">
        <meta name="description" content="Watch the animated GIFs from DevOpReactions/SecurityReactions/TheCodingLove in full-screen.">
        <meta name="author" content="Tobias Kremer/soulchild">
    </head>
    <body>
        <header>
            <a href="$reaction_url">
                <h1>$reaction_no/$reaction_total: $reaction_title</h1>
                <h2>from $reaction_feed</h2>
            </a>
        </header>
        <article>
            <img src="$reaction_image">
        </article>
        <a href="https://github.com/soulchild"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://s3.amazonaws.com/github/ribbons/forkme_right_darkblue_121621.png" alt="Fork me on GitHub"></a>
    </body>
</html>
EOF

        return [ 200, [], [ encode_utf8( $body ) ] ];
    }
};

=head1 AUTHOR

Tobi Kremer, C<< <tobias at funkreich.de> >>

=head1 LICENSE AND COPYRIGHT

Copyright 2013 Tobi Kremer.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=cut
