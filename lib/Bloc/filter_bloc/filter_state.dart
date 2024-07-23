part of 'filter_bloc.dart';

@immutable
sealed class FilterState {}

final class FilterInitial extends FilterState {}

final class GetFiltersErrorState extends FilterState {
  final String message;

  GetFiltersErrorState({required this.message});
}

final class GetFiltersLoadingState extends FilterState {}

final class GetFiltersSuccessfulState extends FilterState {}
