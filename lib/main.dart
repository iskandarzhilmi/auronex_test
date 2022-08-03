import 'dart:developer';

import 'package:auronex_test/features/home/presentation/bloc/home_bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/detail/presentation/bloc/detail_bloc.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/presentation/bloc/login_bloc.dart';
import 'features/presentation/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => DetailBloc(),
        ),
      ],
      child: BlocListener<LoginBloc, LoginStateModel>(
        listener: (context, state) {
          log('LoginStateModel: $state');
          if (state.loginState is LoginUnauthenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          }
          if (state.loginState is LoginAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          }
        },
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
          home: const LoginPage(),
        ),
      ),
    );
  }
}
