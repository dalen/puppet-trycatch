# trycatch

This is a simple Puppet module that adds the functions `try` and `catch`.
They can be used to catch an exception raised in the block passed to `try`.

This module uses the V4 function API, so you need Puppet 4.x to use it or
Puppet 3.7.x with the future parser.

## Example

```puppet
$ret = try() || {
  assert_type('String', 1)
  notice('This code is never reached')
  'return value from try'
}.catch |$exception| {
  notice($exception['class'])
  notice($exception['message'])
  'return value from catch'
}
notice($ret)
```

Output:

```
Notice: Scope(Class[main]): Puppet::PreformattedError
Notice: Scope(Class[main]): Evaluation Error: Error while evaluating a Function Call, assert_type(): Expected type String does not match actual: Integer at /Users/dalen/src/puppet-trycatch/test.pp:2:3
Notice: Scope(Class[main]): return value from catch
Notice: Compiled catalog for river.local in environment production in 0.28 seconds
Notice: Applied catalog in 0.01 seconds
```

### Only catch certain exceptions

```
try() || {
  assert_type('String', 1)
}.catch('ArgumentError', 'RuntimeError') |$exception| {
  notice("Caught ${$exception['class']}")
}
```

Output:

```
Error: Evaluation Error: Error while evaluating a Function Call, assert_type(): Expected type String does not match actual: Integer at /Users/dalen/src/puppet-trycatch/test.pp:2:3 on node river.local
```

Note that this doesn't take exception subclasses into account. It only checks
if the class names match exactly.

## Note that this is a hack, use accordingly
