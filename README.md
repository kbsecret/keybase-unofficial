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

Documentation for the current release can be found on
[RubyDoc](http://www.rubydoc.info/gems/keybase-unofficial/).

### Example

```ruby
require "keybase"

# reads your local configuration
Keybase.current_user # => "yossarian"

# Chatting API
Keybase::Chat.send_message ["yossarian", "you"], "hello"

# REST API
person = Keybase::API.lookup username: "yossarian"
person.them.profile.bio # => "Computer Science and Philosophy student at the University of Maryland, College Park.\n"
```
