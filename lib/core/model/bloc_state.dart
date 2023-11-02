import 'dart:core';

enum Status { initial, loading, success, error }

class BlocStatus<T> {
  final Status status;
  final T? data;

  const BlocStatus({this.status = Status.initial, this.data});

  const BlocStatus.loading()
      : status = Status.loading,
        data = null;

  const BlocStatus.success(T t)
      : status = Status.success,
        data = t;

  const BlocStatus.initial()
      : status = Status.initial,
        data = null;

  const BlocStatus.error()
      : status = Status.error,
        data = null;

  bool isLoading() => status == Status.loading;

  bool isInitial() => status == Status.initial;

  bool isSuccess() => status == Status.success;

  bool isError() => status == Status.error;

}
