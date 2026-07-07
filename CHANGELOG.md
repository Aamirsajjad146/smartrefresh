## 0.0.3

* Upgrade `flutter_lints` dependency constraint to `'>=5.0.0'`
* Update `sdk` environment constraint from `^3.12.2` to `'>=3.12.2'`
* Fix `RefreshController.show()` never completing — the indicator could hang indefinitely
  because its internal `Completer` was never resolved
* Fix unsafe null checks on `RefreshController`'s internal state and on the required
  `refreshController` widget parameter
* Guard against a possible crash from a null `scrollDelta` during scroll updates
* Change `PullToRefresh.onLoading` from `Text` to `Widget` for consistency with `onComplete`/`onFail`
* Replace deprecated `withOpacity`/`alpha` color APIs with `withValues`/`.a`
* Remove dead code: unused `CircularProgressIndicator` class, unused `RefreshCallback` typedef,
  duplicate `dart:math` import
* Rename internal source files to `snake_case` (no change to the public API)
* Add a working widget test (the previous test file had no `main()` and could not run)
* Add a runnable example app under `example/`
* Rewrite README with a complete usage guide and parameter reference
* Add missing root `.gitignore`

## 0.0.2

* TODO: Improve pull to refresh Ui
