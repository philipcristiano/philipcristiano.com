---
title: Risks With Git Tag Triggered Deploys
id: risks-with-git-tag-triggered-deploys
date: 2020-04-16
tags: deployment, git, tag
link:
description:
type: text

---
Git workflows can come in many flavors. Once the code hits a continuous
integration system your workflow will need to trigger a deploy to production. A
common way of handling this is to create a Git tag that will trigger the deployment.
Using a Git tag to trigger the deployment can lead to increased risk against safely
deploying your code.

These risks can be countered in multiple ways, but these are patterns I've seen
in the deployment process for various services.

## Tags can be pushed by anyone with write access

Your process may allow anyone trigger a deploy to production. In many ways this
is a good thing.  In GitHub though, certain branches can be protected in order
to enforce a certain workflow such as requiring each pull request receive
approval from 1 other person.

Tags in Github do now have such a protection. Anyone with write access could push
a tag, bypassing the Github workflow.

## Tags do not have an order

Any commit in the repository can be tagged. There is little difference (to Git)
between a tag on the latest commit and a tag on a commit from 3 months ago. If
your process relies on some semantic meaning for these tags you will have to
encode that information and handle it in your deployment automation.

