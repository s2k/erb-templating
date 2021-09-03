# A behaviour I don't understand

Why do the tests pass when running in 'plain ruby', but **not** when running in the context of bundler?

## Context

```
$ ruby -e 'puts %w(ruby gem bundler).map{|c|"#{c}: "+`#{c} --version`}'
ruby: ruby 3.0.2p107 (2021-07-07 revision 0db68f0233) [x86_64-darwin20]
gem: 3.2.26
bundler: Bundler version 2.2.26
```

```
gem list "^minitest"

*** LOCAL GEMS ***

minitest (5.14.4, 5.14.2)
```

## Running without Bundler and in the context of Bundler

### Running without the Bundler context => PASS

```
stephan@seaside ~/dev/erb_templating $ ls
Gemfile      Gemfile.lock README.md    lib          test
stephan@seaside ~/dev/erb_templating $ ruby test/replacement_test.rb
Run options: --seed 55629

# Running:

.ARGS for render method:
expected_text   : Render 'config_key_and_value_missing' text
template_string : Render '<%= test_key %>' text
config_values   : {}
.

Finished in 0.001163s, 1719.6904 runs/s, 2579.5357 assertions/s.
2 runs, 3 assertions, 0 failures, 0 errors, 0 skips
```

### Running with the Bundler context => FAIL

```
stephan@seaside ~/dev/erb_templating $ bundle exec ruby test/replacement_test.rb
Run options: --seed 57670

# Running:

.ARGS for render method:
expected_text   : Render 'config_key_and_value_missing' text
template_string : Render '<%= test_key %>' text
config_values   : {}
F

Finished in 0.015983s, 125.1330 runs/s, 187.6994 assertions/s.

  1) Failure:
TestRendering#test_render_warning_for_missing_key [test/replacement_test.rb:21]:
--- expected
+++ actual
@@ -1 +1 @@
-"Render 'config_key_and_value_missing' text"
+"Render '' text"


2 runs, 3 assertions, 1 failures, 0 errors, 0 skips
stephan@seaside ~/dev/erb_templating $
```

## The Open Question

Given the support.rb file looks like this:

```ruby
require 'erb'
require 'ostruct'

MISSING_CONFIG_MARKER = :config_key_and_value_missing

def render(template, configuration_data)
  config_object = OpenStruct.new(configuration_data)
  config_object.table.default = MISSING_CONFIG_MARKER
  ERB.new(template).result(config_object.instance_eval { binding })
end
```
Why to the test runs behave differently?
