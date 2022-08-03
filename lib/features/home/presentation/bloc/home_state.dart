part of 'home_bloc.dart';

class HomeStateModel extends Equatable {
  final HomeState homeState;
  final List<UserModel>? userList;

  const HomeStateModel({required this.homeState, this.userList});

  @override
  List<Object?> get props => [homeState, userList];

  factory HomeStateModel.initial() => HomeStateModel(
        homeState: HomeLoading(),
      );

  HomeStateModel copyWith({
    HomeState? homeState,
    List<UserModel>? userList,
  }) {
    return HomeStateModel(
      homeState: homeState ?? this.homeState,
      userList: userList ?? this.userList,
    );
  }
}

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

// class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {}

class HomeError extends HomeState {
  final String error;

  const HomeError({required this.error});

  @override
  List<Object> get props => [error];
}
