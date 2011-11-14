name "server"
description "My server"
run_list(
    "recipe[nginx]",
    "recipe[philipcristiano]")
