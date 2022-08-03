import 'dart:developer';

import 'package:auronex_test/features/home/data/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeStateModel> {
  HomeBloc() : super(HomeStateModel.initial()) {
    on<HomeFetched>(_onHomeFetch);
    on<HomeUserDeleted>(_onHomeUserDeleted);
  }

  Future<void> _onHomeFetch(HomeFetched event, Emitter emit) async {
    try {
      emit(state.copyWith(
        homeState: HomeLoading(),
      ));

      // BotToast.showLoading();

      var result = await Dio().get('https://reqres.in/api/users');

      emit(
        state.copyWith(
          homeState: HomeLoaded(),
          userList: result.data['data']
              .map<UserModel>((item) => UserModel.fromJson(item))
              .toList(),
        ),
      );

      emit(
        state.copyWith(
          homeState: HomeLoaded(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        homeState: HomeError(error: e.toString()),
      ));
      // BotToast.showText(text: e.toString());
    } finally {
      // BotToast.closeAllLoading();
    }
  }

  Future<void> _onHomeUserDeleted(HomeUserDeleted event, Emitter emit) async {
    try {
      emit(state.copyWith(
        homeState: HomeLoading(),
      ));

      var deleteResult =
          await Dio().delete('https://reqres.in/api/users/${event.id}');

      log(deleteResult.statusCode.toString());

      var getResult = await Dio().get('https://reqres.in/api/users');
      // var getResult =
      //     await Dio().get('https://auronex-test.firebaseio.com/user');

      BotToast.showText(text: 'Delete successful.');
      emit(
        state.copyWith(
          homeState: HomeLoaded(),
          userList: getResult.data['data']
              .map<UserModel>((item) => UserModel.fromJson(item))
              .toList(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        homeState: HomeError(error: e.toString()),
      ));
      BotToast.showText(text: 'Delete failed.');
      // BotToast.showText(text: e.toString());
    } finally {
      BotToast.closeAllLoading();
    }
  }
}
