+++
date = "2024-08-07T10:21:00.000Z"

[taxonomies]
tags = ["zola", "decapcms", "toml"]
+++
Based on [a Github issue](https://github.com/decaporg/decap-cms/issues/1152) I was able to get a collection with [Zola taxonomies](https://www.getzola.org/documentation/content/taxonomies/) writing the proper TOML-frontmatter format. 

```
collections:
- ...
  fields: 
  - label: "Taxonomies"
    name: "taxonomies"
    widget: "object"
    fields:
    - { label: "Tags", name: "tags", widget: "list", allow_add: true}
```

This is written out into the frontmatter as 

```toml
++
[taxonomies]
tags = ["tag"]
+++
