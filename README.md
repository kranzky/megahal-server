[![Fly Deploy](https://github.com/kranzky/megahal-server/actions/workflows/main.yml/badge.svg)](https://github.com/kranzky/megahal-server/actions/workflows/main.yml)

# MegaHAL Server

MegaHAL Server is a Rails server that allows users to chat with [MegaHAL](https://github.com/kranzky/megahal), a learning chatterbot.

You can [chat with MegaHAL online](https://megahal.kranzky.com) right now!

## Deployment

```
> brew bundle
> rvm use `cat .ruby-version`@`cat .ruby-gemset`
> bundle install
> fly deploy --remote-only
```

Copyright
---------

Copyright (c) 2014-2022 Jason Hutchens. See UNLICENSE for further details.
