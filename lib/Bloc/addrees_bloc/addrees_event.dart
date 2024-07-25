// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'addrees_bloc.dart';

@immutable
sealed class AddreesEvent {}

class GetAddreesEvent extends AddreesEvent {}

class ConfirmOrderEvent extends AddreesEvent {
  final int totalCost;
  final int addreesId;

  ConfirmOrderEvent({required this.totalCost, required this.addreesId});
}

class SetNewAddreesEvent extends AddreesEvent {
  final AddreesModel addreesModel;
  SetNewAddreesEvent({
    required this.addreesModel,
  });
}

class SelectAddreesEvent extends AddreesEvent {
  final int index;
  SelectAddreesEvent({
    required this.index,
  });
}

class DeleteAddreesEvent extends AddreesEvent {
  final int addreesId;
  final int index;
  DeleteAddreesEvent({required this.addreesId, required this.index});
}
