# Add Refresh Controller
```
final RefreshController _refreshController = RefreshController();
```
# add code

```
PullToRefresh(
        onRefresh: _handleRefresh,
        showChildOpacityTransition: false,
        backgroundColor: Colors.transparent,
        tColor: Colors.grey,
        onFail: failedIndicator(),
        onComplete: completeindicator(),
        onLoading: loadingindicator(),
        refreshController: _refreshController,
        child: StreamBuilder<int>(
          stream: counterStream,
          builder: (context, snapshot) {
            return ListView.builder(...);
          },
        ),
      )

```



```
  loadingindicator() {
    return const Text('Refreshing..',
        style: TextStyle(
            color: Colors.grey, fontFamily: 'SourceSansPro-SemiBold'));
  }

  completeindicator() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Icon(
          Icons.done,
          color: Colors.grey,
        ),
        SizedBox(
          width: 10,
        ),
        Text('Refresh Completed',
            style: TextStyle(
                color: Colors.grey, fontFamily: 'SourceSansPro-SemiBold'))
      ],
    );
  }

  failedIndicator() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Icon(
          Icons.close,
          color: Colors.grey,
        ),
        SizedBox(
          width: 10,
        ),
        Text('Failed',
            style: TextStyle(
                color: Colors.grey, fontFamily: 'SourceSansPro-SemiBold'))
      ],
    );
  }

```
