<!---
layout: post
title: vimrc Updates
tags:
- vim
- gundo
- dotfile
-->

I've kept my VIM/dot files online for a while in [my
Github](https://github.com/philipcristiano/) but I recently spent some time to
update my .vimrc file.

One of the changes that bugged me on OSX is that it ships with VIM 7.2 which
doesn't have ColorColumn support. I like highlighting the 80th column in
Python. As I discovered, the code to do this is :

{% highlight vim %}
    if version >= 730
        autocmd FileType python set cc=80
        hi ColorColumn ctermbg=darkgrey guibg=darkgrey
    endif
{% endhighlight %}

Another change was to add [Gundo](https://github.com/neh/gundo.vim) support.
This adds a window to navigate your undo tree, an incredibly useful feature.
