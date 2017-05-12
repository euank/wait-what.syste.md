## Intro 1

Hello everyone, thanks for joining me for my talk.

I know you had other cool talks you could have gone to, like that blockchain talk happening over there.


Really though, thanks for coming to this one.

If it's not clear from the title, this is a talk about systemd.

What's more, the title says 'init', but this is about all of systemd. The whole shebang. The entire project. Not just the init portion.

Mostly though, we're talking about the weird stuff hiding under all the other stuff.

## Who am I

First of all though, let me introduce myself.

I'm Euan, I help lead the distro team at CoreOS.

As you probably know, we build a distro at CoreOS called Container Linux.

## Container Linux

I mention this because Container Linux is pretty light and systemd is a core component of it.

### By image size

In fact, by weight, container linux is mostly systemd!


### By version

But where systemd really shines in container linux is by version number.

We ship less, which is version v478.
And systemd is number 2 at v233

At v233, it's the second biggest-versioned thing we ship. Obviously that means
it's important.

As an FYI, the largest-versioned thing we ship is less at version 478
