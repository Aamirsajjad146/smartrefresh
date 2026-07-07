# smartrefresh

A Flutter package that wraps any scrollable widget (`ListView`, `CustomScrollView`, etc.) with a
customizable pull-to-refresh indicator, and lets you show distinct widgets for the loading,
success, and failure states of a refresh.

## Features

- Drop-in wrapper around any scrollable `child`.
- Separate `onLoading`, `onComplete`, and `onFail` widgets for each stage of a refresh.
- Reports success/failure explicitly via `RefreshController`, so you control exactly when the
  indicator dismisses.
- Configurable colors, height, border width, and animation speed/duration.

A full runnable app is available in [`example/`](example/lib/main.dart) — run it with:

```
cd example
flutter run
```

## Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  smartrefresh:
    git:
      url: https://github.com/Aamirsajjad146/smartrefresh.git
```

Then run:

```
flutter pub get
```

## Usage

Create a `RefreshController` that you'll use to tell the widget when your refresh finished:

```dart
final RefreshController _refreshController = RefreshController();
```

Wrap your scrollable content in a `PullToRefresh` widget:

```dart
PullToRefresh(
  refreshController: _refreshController,
  onRefresh: _handleRefresh,
  onLoading: loadingIndicator(),
  onComplete: completeIndicator(),
  onFail: failedIndicator(),
  showChildOpacityTransition: false,
  backgroundColor: Colors.transparent,
  tColor: Colors.grey,
  child: ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) => ListTile(title: Text(items[index])),
  ),
)
```

In `onRefresh`, run your refresh logic and then report the result back through the controller —
this is what tells `PullToRefresh` to dismiss the indicator:

```dart
Future<void> _handleRefresh() async {
  try {
    await fetchLatestItems();
    _refreshController.refreshCompleted();
  } catch (e) {
    _refreshController.refreshFailed();
  }
}
```

The three indicator widgets are typically small, static widgets:

```dart
Widget loadingIndicator() {
  return const Text(
    'Refreshing..',
    style: TextStyle(color: Colors.grey),
  );
}

Widget completeIndicator() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Icon(Icons.done, color: Colors.grey),
      SizedBox(width: 10),
      Text('Refresh Completed', style: TextStyle(color: Colors.grey)),
    ],
  );
}

Widget failedIndicator() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Icon(Icons.close, color: Colors.grey),
      SizedBox(width: 10),
      Text('Failed', style: TextStyle(color: Colors.grey)),
    ],
  );
}
```

Don't forget to dispose the controller with its owning widget's state:

```dart
@override
void dispose() {
  _refreshController.dispose();
  super.dispose();
}
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `child` | `Widget` | yes | The scrollable widget to wrap (e.g. `ListView`). |
| `refreshController` | `RefreshController` | yes | Reports refresh completion/failure back to the widget. |
| `onRefresh` | `VoidCallback?` | yes | Called when the user drags far enough to trigger a refresh. |
| `onLoading` | `Widget` | yes | Shown next to the spinner while refreshing. |
| `onComplete` | `Widget` | yes | Shown when `refreshController.refreshCompleted()` is called. |
| `onFail` | `Widget` | yes | Shown when `refreshController.refreshFailed()` is called. |
| `pullIndecator` | `Widget?` | no | Custom widget shown while dragging, before the refresh is armed. |
| `backgroundColor` | `Color?` | no | Foreground color of the progress indicator. Defaults to the theme's secondary color. |
| `tColor` | `Color?` | no | Background color behind the progress indicator. Defaults to the theme's canvas color. |
| `height` | `double?` | no | Distance the indicator settles at. Defaults to `100.0`. |
| `borderWidth` | `double` | no | Border width of the progress ring. Defaults to `2.0`. |
| `springAnimationDurationInMilliseconds` | `int` | no | Duration of the spring/settle animation. Defaults to `1000`. |
| `animSpeedFactor` | `double` | no | Multiplier (`>= 1.0`) to speed up the closing animation. Defaults to `1.0`. |
| `showChildOpacityTransition` | `bool` | no | Whether the child fades out while the indicator is shown. Defaults to `true`. |

## License

See [LICENSE.md](LICENSE.md).
