import 'dart:core';

enum _Status { initial, loading, success, none }

class BlocStatus<T> {
  final _Status status;
  final T? data;

  const BlocStatus({this.status = _Status.initial,this.data});

  const BlocStatus.loading()
      : status = _Status.loading,
        data = null;

  const BlocStatus.success(T t)
      : status = _Status.success,
        data = t;

  const BlocStatus.initial()
      : status = _Status.initial,
        data = null;

  bool isLoading() => status == _Status.loading;

  bool isInitial() => status == _Status.initial;

  bool isSuccess() => status == _Status.success;
}
