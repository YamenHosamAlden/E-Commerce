part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}
class SearchResultLoadingState extends SearchState {}

class SearchResultSuccessfulState extends SearchState {}


class SearchResultErrorState extends SearchState {
  final String message;
  SearchResultErrorState({required this.message});
}


class CompletionSearchLoadingState extends SearchState {}

class CompletionSearchSuccessfulState extends SearchState {}


class CompletionSearchErrorState extends SearchState {
  final String message;
  CompletionSearchErrorState({required this.message});
}