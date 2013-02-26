# Reevoo ~ Software Test

## Defining Discount Rules

Rules can be defined whilst instantiating `Rule` or via `Rule#add_rule` as a `Hash`.

The following options are permitted:

* `apply_multiple: true`: ensure the discount is applied once for each
multiple occurance against count; this ensures 'buy-1-get-1-free' type
deals will apply for multiple purchases, i.e. purchase four items and get two
free.

* `apply_each: true`: ensure the discount is applied once for each
occurance as long as the number of items meets the minimum count as per
the rule.

If the above mentioned options are not specified, discounts will only be
applied once, i.e. purchase four items and only get one free.

# License

Copyright (c) 2013 Michael de Silva. Distributed under the MIT License. See
LICENSE.txt for further details.
