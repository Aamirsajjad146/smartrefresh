import 'dart:async';

import 'package:flutter/material.dart';

import 'pullToRefresh.dart';


/// The signature for a function that's called when the user has dragged a
/// [PullToRefresh] far enough to demonstrate that they want the app to
/// refresh. The returned [Future] must complete when the refresh operation is
/// finished.
///
/// Used by [PullToRefresh.onRefresh].
///typedef RefreshCallback = Future<void> Function();

class RefreshController {

  late PullToRefreshState _pullToRefreshState;

  /// Refresh construster
  RefreshController();

  void setFRefreshState(PullToRefreshState pullToRefreshState) {
    _pullToRefreshState = pullToRefreshState;
  }

  /// this function will call on succeed process
  Future<void> refreshCompleted() async {
    if (_pullToRefreshState !=  null && _pullToRefreshState.mounted) {
      _pullToRefreshState.onComplete();
    }
  }

  /// this function will call for failed process
  Future<void> refreshFailed() async {
    if (_pullToRefreshState !=  null && _pullToRefreshState.mounted) {
      _pullToRefreshState.onFailed();
    }
  }

  /// this will call on dispose
  void dispose(){}

}