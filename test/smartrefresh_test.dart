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
}
