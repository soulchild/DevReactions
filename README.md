# DevReactions

Love the animated GIFs from [DevOpsReaction](http://devopsreactions.tumblr.com) and [TheCodingLove](http://thecodinglove.com)? 

This little Perl app fetches those feeds and displays the GIFs in a random order in fullscreen without any clutter.

[Example (on Heroku)](http://devreactions.herokuapp.com/)

## Installation

Do yourself a favor and install [cpanm](https://metacpan.org/module/App::cpanminus#INSTALLATION), then it's as easy as:

```bash
perl Makefile.PL
cpanm --installdeps .
plackup
```

Fire up your browser and go to: [http://localhost:5000](http://localhost:5000). If you're using Google Chrome, hit cmd+Shift+F for full-screen mode. 
If you're on OS X, you might like [Websaver](https://code.google.com/p/websaver/), which let's you display a website (e.g. this app) as a screen-saver.

Enjoy! :)