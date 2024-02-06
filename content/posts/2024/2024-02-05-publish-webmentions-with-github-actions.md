+++
title      = "Send Webmentions with Github Actions"
+++

As I start [working with webmentions](@/posts/2024/2024-02-04-webmentions.md) I needed to find a way to publish webmentions as part of the build/release process for this site. I'm currently using [Github Actions](https://docs.github.com/en/actions) to build the site and upload to [Netlify](http://netlify.com/).

[webmention.app](https://webmention.app/) came up frequently when I searched around for how to publish webmentions. It supports RSS/Atom as a feed, although the docs suggest using [IFTTT](https://ifttt.com) to trigger webhooks. Github Actions can do that though! For whatever reason webmention.app didn't seen to find any links in my feed. As I was trying to figure out why by [using the command line](https://webmention.app/docs#using-the-command-line) I discovered that the CLI version was able to find the links in my feed!

Adding this as a step post-release

```yaml
- name: Send Webmentions
  run: |
    npm install @remy/webmention
    npx webmention ${{ secrets.WEBMENTION_TARGET_URL }} --limit=0 --send
```

In my pull-requests I have a variation of this, removing `--send` and using the temporary Netlify URL for the PR so I can see what webmentions would be sent.

As part of using my atom feed for this I now only include the last 10 posts in my feed to avoid sending lots of old webmentions, most of which didn't seem to work as the links are dead.
