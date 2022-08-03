part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeFetched extends HomeEvent {}

class HomeUserDeleted extends HomeEvent {
  final int id;

  const HomeUserDeleted({required this.id});

  @override
  List<Object> get props => [id];
}
