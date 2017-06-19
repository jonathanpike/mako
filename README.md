# Mako 🥛 [![Build Status](https://travis-ci.org/jonathanpike/mako.svg?branch=master)](https://travis-ci.org/jonathanpike/mako) [![Coverage Status](https://coveralls.io/repos/github/jonathanpike/mako/badge.svg?branch=master)](https://coveralls.io/github/jonathanpike/mako?branch=master)

Mako is a static-site generating RSS reader.  Mako is also my son's name for
milk.

I designed Mako with the following principals in mind: 

1. RSS feeds are freely available, so reader software should be freely
   available.
2. RSS feeds are part of the web, so reader software should be part of the web.

## Installation

To install Mako, do:

    $ gem install mako_rss

Once the gem is installed, you'll need to generate a new Mako site.  You can do
this in 1 of 2 ways.  

1. If you already have a directory that you want Mako to live in, run: 

    $ mako new

2. If you don't have a directory and want Mako to create on, run: 

    $ mako new path/to/directory

In your new Mako site, you'll see a directory structure like this: 

```
.
├── sample_subscriptions
|   ├── subscriptions.json
|   ├── subscriptions.txt
|   └── subscriptions.xml
├── site
├── themes
|   ├── sass
|   |  ├── _fonts.scss
|   |  ├── _layout.scss
|   |  ├── _reboot.scss
|   |  ├── _utitilies.scss
|   |  └── _variables.scss
|   ├── simple.html.erb
|   └── simple.scss
├── Gemfile
└── config.yaml
```

## Adding Feeds

Once Mako is installed and your Mako site has been created, the next step is to
add your own feeds.  Mako currently supports 3 formats: 

1. OPML
2. JSON 
3. Plain Text

In the [`sample_subscriptions`](/lib/templates/sample_subscriptions) directory, you'll see an example of each format.
Whichever you choose, place the file in the root directory and be sure its name
is `subscriptions`.  The file extension (`.xml`/`.opml`, `.json`, or `.txt`)
will tell Mako what kind of subscription file you have.

## Configuration

Mako has very few configuration options.  You can see all of them in the
comments in [`config.yaml`](/lib/templates/config.yaml). 

## Building your Site

Once you've added your subscriptions, you can build your Mako site for the first
time.  By default, Mako only builds the HTML portion of the site with the `mako
build` command.  Since the CSS has not been generated, use the `--with-sass`
flag, like this: 

    $ mako build --with-sass

The built files will be present in the `site` directory after the `build`
command has been run. 

At present, Mako only displays the last 2 days worth of content from your feeds.
If a feed has not been updated in the last 2 days, it will not be displayed on
your Mako site. Similarly, articles that were published > 2 days in the past
will not be displayed on your Mako site. 

## Themes 

Mako comes with a simple theme of my own design (and own liking).  Perhaps you
want something different.  Mako's themes are templated with
[ERB](https://ruby-doc.org/stdlib-2.4.1/libdoc/erb/rdoc/ERB.html).  You have
access to the following convenience methods: 
  - `today` - Gives you the current date in Day, `Date Month Year` format.
  - `last_updated` - Gives you the current date and time in `day month year
  hour:minute:second` format.

Within your template, you can access the feed data through the `feeds` array.
The `feeds` array contains `feed` objects, which have the following attributes: 
  - `title` - a string of the feed title.
  - `url` - a string of the feed url.
  - `articles` - an array of the articles associated with the feed.

To access the `articles` within a `feed`, you can use:
  - `articles_desc` - sorts the array of articles by newest first.
  - `articles_asc` - sorts the array of articles by oldest first.

`articles` contain the following attributes: 
  - `title` - a string of the article title.
  - `url` - a string of the article url.
  - `published` - a `Time` instance of the published date. Can also be accessed
    by `formatted_published` to get it as formatted string.
  - `summary` - a string of the article content.

When in doubt, check out the implementation of [my
theme](/lib/templates/themese/simple.html.erb).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jonathanpike/mako.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

