# A behaviour I don't understand

Why do the tests pass when running in 'plain ruby', but **not** when running in the context of bundler?

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

