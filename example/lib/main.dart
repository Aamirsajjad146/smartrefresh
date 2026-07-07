import 'package:flutter/material.dart';
import 'package:smartrefresh/smartrefresh.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'smartrefresh example',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const RefreshDemoPage(),
    );
  }
}

class RefreshDemoPage extends StatefulWidget {
  const RefreshDemoPage({super.key});

  @override
  State<RefreshDemoPage> createState() => _RefreshDemoPageState();
}

class _RefreshDemoPageState extends State<RefreshDemoPage> {
  final RefreshController _refreshController = RefreshController();
  final List<String> _items = List.generate(15, (i) => 'Item ${i + 1}');

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _items.insert(0, 'New item ${DateTime.now().millisecondsSinceEpoch}');
    });

    _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('smartrefresh example')),
      body: PullToRefresh(
        refreshController: _refreshController,
        onRefresh: _handleRefresh,
        onLoading: const Text('Refreshing..', style: TextStyle(color: Colors.grey)),
        onComplete: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.done, color: Colors.grey),
            SizedBox(width: 10),
            Text('Refresh Completed', style: TextStyle(color: Colors.grey)),
          ],
        ),
        onFail: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.close, color: Colors.grey),
            SizedBox(width: 10),
            Text('Failed', style: TextStyle(color: Colors.grey)),
          ],
        ),
        child: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) => ListTile(title: Text(_items[index])),
        ),
      ),
    );
  }
}
