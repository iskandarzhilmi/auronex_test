part of 'login_bloc.dart';

class LoginStateModel extends Equatable {
  final LoginState loginState;

  const LoginStateModel({required this.loginState});

  @override
  List<Object?> get props => [loginState];

  factory LoginStateModel.initial() => LoginStateModel(
        loginState: LoginInitial(),
      );

  LoginStateModel copyWith({
    LoginState? loginState,
  }) {
    return LoginStateModel(
      loginState: loginState ?? this.loginState,
    );
  }
}

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginAuthenticated extends LoginState {}

class LoginUnauthenticated extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  final String error;

  LoginError({required this.error});

  @override
  List<Object> get props => [error];
}
