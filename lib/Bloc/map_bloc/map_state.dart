part of 'map_bloc.dart';

@immutable
sealed class MapState {}

final class MapInitial extends MapState {}

final class GetLocationLoadingState extends  MapState{}
final class  GetLocationSuccessfulState extends MapState {}
