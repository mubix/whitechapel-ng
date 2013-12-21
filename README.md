whitechapel-ng beta
==============

This is a rails port of whitechapel. It is still in a beta state. More
features are in work and some existing features may cause issues.

Whitechapel is ment for you to feed known passwords from your
environment into the tool for indexing. It will also take the known
cleartext passwords and hash them in various form so you can search for
the cleartext equivalent without needing to crack the hash.

The app does not have authentication so host/protect it wisely.

At this point I recommend you run in dev mode (default for rails).

Setup-ish:
----------
* git clone
* cd whitechapel-ng
* cp config/database.yml.example config/database.yml
* vim config/database.yml (Setup your database)
* rake db:setup
* bin/delayed_job start
* rails s
* open the website
