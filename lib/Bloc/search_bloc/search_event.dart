// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class SearchResultEvent extends SearchEvent {
  final String result;
  SearchResultEvent({
    required this.result,
  });
}

class CompletionSearchEvent extends SearchEvent {}
