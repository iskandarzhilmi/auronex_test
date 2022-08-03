part of 'detail_bloc.dart';

class DetailStateModel extends Equatable {
  final DetailState state;
  final UserModel? user;

  const DetailStateModel({required this.state, required this.user});

  @override
  List<Object?> get props => [state, user];

  factory DetailStateModel.initial() => DetailStateModel(
        state: DetailInitial(),
        user: null,
      );

  DetailStateModel copyWith({
    DetailState? state,
    UserModel? user,
  }) {
    return DetailStateModel(
      state: state ?? this.state,
      user: user ?? this.user,
    );
  }
}

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

class DetailInitial extends DetailState {}

class DetailLoading extends DetailState {}

class DetailSuccess extends DetailState {}

class DetailFailed extends DetailState {
  final String error;

  const DetailFailed({required this.error});

  @override
  List<Object> get props => [error];
}
