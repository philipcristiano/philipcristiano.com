-module(index).

-export([data/1, site/1]).

-export([date_to_long_string/1,
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
    #{
      "site/index.html" => {template, "src/index.html", #{site_root => "/"}},
      "site/css/*" => {files, "src/css/*"},
      "site/js/*" => {files, "src/js/*"},

      %"site/recipes/index.html" =>
      %    {template, "templates/recipes.html",
      %     #{site_root => "../"}},

      "site/{{post.id}}.html" =>
          {template_map, "src/templates/post.html", {post, posts(Data)},
           #{site_root => "/"}}

    }.

date_to_long_string(Var) ->
    Var.
tag_links(undefined) ->
    "";
tag_links(Var) ->
    %SplitTags = binary:split(binary:list_to_bin(Var), <<",">>,  [global]),
    %TODO: Generate links for this
    Var.

posts(Data) -> plist:value(daily_posts, Data) ++ plist:value(monthly_posts, Data).

