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
      "site/css/*" => {files, "site_src/static/bootstrap-4.6.0/css/*"},
      "site/js/*" => {files, "site_src/static/bootstrap-4.6.0/js/*"},

      %"site/recipes/index.html" =>
      %    {template, "templates/recipes.html",
      %     #{site_root => "../"}},

      "site/{{post.id}}.html" =>
          {template_map, "src/_layouts/post.html", {post, posts(Data)},
           #{site_root => "/"}}

    }.

date_to_long_string(Var) ->
    io:format("date to long string ~p~n", [Var]),
    <<"DATE_TO_LONG_STRING_TODO">>.
tag_links(Var) ->
    io:format("Tag Links ~p~n", [Var]),
    <<"TAG_LINKS_TODO">>.

posts(Data) -> plist:value(daily_posts, Data) ++ plist:value(monthly_posts, Data).

