import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartrefresh/smartrefresh.dart';

void main() {
  testWidgets('PullToRefresh renders its child', (WidgetTester tester) async {
    final RefreshController refreshController = RefreshController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PullToRefresh(
            refreshController: refreshController,
            onRefresh: () {},
            onLoading: const Text('Loading'),
            onComplete: const Text('Completed'),
            onFail: const Text('Failed'),
            child: ListView(
              children: const <Widget>[
                ListTile(title: Text('Item 1')),
                ListTile(title: Text('Item 2')),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text('Item 2'), findsOneWidget);
  });

  test('refreshCompleted/refreshFailed do not throw before attaching to a PullToRefresh', () async {
    final RefreshController controller = RefreshController();

    await controller.refreshCompleted();
    await controller.refreshFailed();
  });

  testWidgets('show() future completes once refreshCompleted is called', (WidgetTester tester) async {
    final RefreshController refreshController = RefreshController();
    final GlobalKey<PullToRefreshState> key = GlobalKey<PullToRefreshState>();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PullToRefresh(
            key: key,
            refreshController: refreshController,
            onRefresh: () {},
            onLoading: const Text('Loading'),
            onComplete: const Text('Completed'),
            onFail: const Text('Failed'),
            child: ListView(
              children: const <Widget>[
                ListTile(title: Text('Item 1')),
              ],
            ),
          ),
        ),
      ),
    );

    bool completed = false;
    key.currentState!.show()!.then((_) => completed = true);

    // The animation ticker establishes its start time on the first pumped
    // frame, so pump once to start it before advancing the clock.
    await tester.pump();
    // Let the spring/snap animation run until the refresh callback fires.
    await tester.pump(const Duration(milliseconds: 1100));
    expect(completed, isFalse);

    refreshController.refreshCompleted();
    // onComplete() has its own internal 500ms delay before completing.
    await tester.pump(const Duration(milliseconds: 600));

    expect(completed, isTrue);
  });
}
