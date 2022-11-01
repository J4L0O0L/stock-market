part of 'detail_bloc.dart';

@immutable
abstract class DetailState {}

class DetailInitial extends DetailState {}

class DetailNoConnection extends DetailState {}

class DetailLoading extends DetailState {}

class DetailLoadingError extends DetailState {
  final dynamic error;

  DetailLoadingError({@required this.error});
}

class DetailLoaded extends DetailState {
  final DetailModel detailModel;
  final StockRange range;

  DetailLoaded({
    required this.detailModel,
    required this.range,
  });
}
