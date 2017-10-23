The solution itself is straightforward, in this case the policy has data on
it's rules and the policy base mixin adds mechanism to decide if it should
apply that policy or not in a specific way.

Depending on the direction needed, there are two ways improvements can be
made, the data on the policies can be extracted to a declarative schema (json,
yaml) if the year/month/day logic is maintained. In case there's a need for more
complex policies, the logic should be extracted from the policy itself and go to
the retention, it they get much more complex, rule classes should evolve to
accomodate that logic.

The base policy tests cover most of the logic currently, the specific policy
tests I consider more as integration tests. An obvious improvement is that
the tests with dates can be troublesome, I refrained from adding any more
gems, but timecop (or injecting the date we want to compare against on the
constructor) should be added to make the tests more deterministic.
