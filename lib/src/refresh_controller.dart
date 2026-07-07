import 'dart:async';

import 'pull_to_refresh.dart';


class RefreshController {

  PullToRefreshState? _pullToRefreshState;

  /// Refresh construster
  RefreshController();

  void setFRefreshState(PullToRefreshState pullToRefreshState) {
    _pullToRefreshState = pullToRefreshState;
  }

  /// this function will call on succeed process
  Future<void> refreshCompleted() async {
    if (_pullToRefreshState != null && _pullToRefreshState!.mounted) {
      _pullToRefreshState!.onComplete();
    }
  }

  /// this function will call for failed process
  Future<void> refreshFailed() async {
    if (_pullToRefreshState != null && _pullToRefreshState!.mounted) {
      _pullToRefreshState!.onFailed();
    }
  }

  /// this will call on dispose
  void dispose(){}

}