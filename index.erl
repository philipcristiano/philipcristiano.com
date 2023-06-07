-module(index).

-export([data/1, site/1]).

-export([date_to_long_string/1,
         post_to_link/1,
         tag_links/1]).

data(_) ->
    #{
     site     => {eterm,    "site.config"},
     daily_posts => {markdown, "posts/*/*/*/*.markdown"},
     monthly_posts => {markdown, "posts/*/*/*.markdown"}
     % snippets => {markdown, "snippets/*.md"}
     }.

site(Data) ->
    io:format("Data ~p~n", [Data]),
    Host = "https://philipcristiano.com",
    Now = calendar:system_time_to_rfc3339(erlang:system_time(second)),
    #{
      "site/index.html" => {template, "src/index.html", #{site_root => "/"}},
      "site/css/*" => {files, "src/css/*"},
      "site/js/*" => {files, "src/js/*"},
      "site/.well-known/matrix/*" => {files, "src/well-known/matrix/*"},
      "site/.well-known/*" => {files, "src/well-known/*.json"},
      "site/atom.xml" => {template, "src/atom.xml", #{site_root => "/", now => Now, host => Host}},

      %"site/recipes/index.html" =>
      %    {template, "templates/recipes.html",
      %     #{site_root => "../"}},

      "site/{{post.id}}.html" =>
          {template_map, "src/templates/post.html", {post, posts(Data)},
           #{site_root => "/"}}

    }.

date_to_long_string(undefined) ->
    calendar:system_time_to_rfc3339(0);
date_to_long_string(Var) ->
    calendar:system_time_to_rfc3339(qdate:to_unixtime(Var)).

post_to_link(undefined) ->
    "/";
post_to_link(Post) ->
    "/" ++ Post ++ ".html".

tag_links(undefined) ->
    "";
tag_links(Var) ->
    %SplitTags = binary:split(binary:list_to_bin(Var), <<",">>,  [global]),
    %TODO: Generate links for this
    Var.

posts(Data) -> plist:value(daily_posts, Data) ++ plist:value(monthly_posts, Data).

