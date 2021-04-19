-module(index).

-export([data/1, site/1]).

data(_) ->
    #{
     site     => {eterm,    "site.config"},
     recipes => {markdown, "site_src/recipes/*/index.md"},
     snippets => {markdown, "snippets/*.md"}
     }.

site(Data) ->
    io:format("Data ~p~n", [Data]),
    #{
      "site/index.html" => {template, "templates/index.html", #{site_root => "/"}},
      "site/static/bootstrap-4.6.0/css/*" => {files, "site_src/static/bootstrap-4.6.0/css/*"},
      "site/static/bootstrap-4.6.0/js/*" => {files, "site_src/static/bootstrap-4.6.0/js/*"},

      "site/static/hz/css/*" => {files, "site_src/static/hz/css/*"},
      "site/recipes/index.html" =>
          {template, "templates/recipes.html",
           #{site_root => "../"}},

      "site/recipes/{{recipe.id}}.html" =>
          {template_map, "templates/recipe.html", {recipe, recipes(Data)},
           #{site_root => "/"}}

      %"site/static/js/*.js" => {files, "site_src/static/js/*.js",
      %                      #{site_root => "/"}}
      %"site/static/css/*.css" => {files, "site_src/static/css/*.css",
      %                      #{site_root => "/"}},
      % "site/static/fonts/*.*" => {files, "site_src/static/fonts/*.*",
      %                       #{site_root => "/"}}
    }.


    %   "site/examples/index.erl.html" =>
    %       {template, "templates/example.html",
    %        #{site_root => "../",
    %          example_file => "index.erl"}},

    %   "site/assets/*.css" =>
    %       {files, "assets/*.css"}
    % }.

recipes(Data) -> plist:value(recipes, Data).
