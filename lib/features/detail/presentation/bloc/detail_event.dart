part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class DetailUpdateButtonPressed extends DetailEvent {
  final UserModel user;

  const DetailUpdateButtonPressed({required this.user});

  @override
  List<Object> get props => [user];
}

class DetailCreateButtonPressed extends DetailEvent {
  final UserModel user;

  const DetailCreateButtonPressed({required this.user});

  @override
  List<Object> get props => [user];
}
