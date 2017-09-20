keybase-unofficial
==================

[![Gem Version](https://badge.fury.io/rb/keybase-unofficial.svg)](https://badge.fury.io/rb/keybase-unofficial)

An unofficial ruby library for Keybase and the Keybase API.

Work in progress.

### Installation

```bash
$ gem install keybase-unofficial
```

### Documentation

Documentation for keybase-unofficial is split across its three sublibraries:

* [keybase-unofficial-core docs](http://www.rubydoc.info/gems/keybase-unofficial-core/)
* [keybase-unofficial-api docs](http://www.rubydoc.info/gems/keybase-unofficial-api/)
* [keybase-unofficial-local docs](http://www.rubydoc.info/gems/keybase-unofficial-local/)

### Examples

```ruby
require "keybase"

# reads your local configuration
Keybase::Local.current_user # => "yossarian"

# Chatting API
Keybase::Local::Chat.send_message ["yossarian", "you"], "hello"

# REST API
person = Keybase::API.lookup username: "yossarian"
person.them.profile.bio # => "Computer Science and Philosophy student at the University of Maryland, College Park.\n"
```
