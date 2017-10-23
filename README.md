Summary
---
A service that calculates if a snapshot should be retained or discarded
according to tiers of policies.

Setup
---
You only need ruby and bundler to run this service, make sure you have those and
run:
```shell
bundle install
```

Tests
---
The tests use rspec, to run them, execute the line below from the root of the
project
```shell
rspec .
```

Example Program
---
There is an example program with some dates and outputs to fiddle with, you can
run it with
```shell
./example_consumer.rb
```
