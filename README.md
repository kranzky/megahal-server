[![Fly Deploy](https://github.com/kranzky/megahal-server/actions/workflows/main.yml/badge.svg)](https://github.com/kranzky/megahal-server/actions/workflows/main.yml)

# MegaHAL Server

MegaHAL Server is a Rails server that allows users to chat with [MegaHAL](https://github.com/kranzky/megahal), a learning chatterbot.

You can [chat with MegaHAL online](https://megahal.kranzky.com) right now!

### Setup

This will install `redis` and `flyctl`, along with the various Ruby gems,
assuming you're running [rvm](https://rvm.io/) or similar.

```
> brew bundle
> rvm use `cat .ruby-version`@`cat .ruby-gemset`
> bundle install
```

### Development

Running the `./bin/dev` script will start the Rails server and will start the
`./bin/megahal-server` script as well, which should be enough to get things
up-and-running on your local machine.

### Deployment

I deploy to [fly.io](https://fly.io) with a GitHub action which does the
following:

```
> fly deploy --remote-only
```

You can run MegaHAL on the free tier, but there is some additional configuration
that needs to be done (for example, you will need to launch a redis instance
too, using the configuration in the `redis` directory, you will need to attach a
persistent storage volume, and you'll need to define the `REDIS_URL` and
`MOUNT_PATH` secrets too). Look at the `fly.toml` configuration files for
details.

# Copyright

Copyright (c) 2014-2022 Jason Hutchens. See UNLICENSE for further details.
