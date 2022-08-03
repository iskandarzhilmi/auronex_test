import 'dart:developer';

import 'package:auronex_test/features/home/data/models/user_model.dart';
import 'package:auronex_test/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../detail/presentation/pages/detail_page.dart';
import '../../../presentation/bloc/login_bloc.dart';
import '../../../presentation/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ValueNotifier<bool> _notifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return DetailPage(
                  user: UserModel.empty(),
                );
              },
            ),
          ).then((_) {
            context.read<HomeBloc>().add(HomeFetched());
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          BlocConsumer<HomeBloc, HomeStateModel>(
            listener: (context, state) {},
            builder: (context, state) {
              Widget content = const Center(
                child: Text('No data'),
              );

              if (state.homeState is HomeLoading) {
                content = const SizedBox(
                  height: 100,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
                context.read<HomeBloc>().add(
                      HomeFetched(),
                    );
              }
              if (state.homeState is HomeLoaded) {
                content = ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.userList!.length,
                  itemBuilder: (context, index) {
                    var user = state.userList![index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.avatar!),
                      ),
                      title: Text('${user.firstName} ${user.lastName}'),
                      subtitle: Text(user.email!),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                    user: user,
                                  ),
                                ),
                              ).then((_) {
                                context.read<HomeBloc>().add(HomeFetched());
                              });
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                          IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                log('Delete user ${user.id}');
                                context.read<HomeBloc>().add(
                                      HomeUserDeleted(id: user.id!),
                                    );
                              }),
                        ],
                      ),
                    );
                  },
                );
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        child: const Text('Logout'),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                          context.read<LoginBloc>().add(
                                LogoutButtonPressed(),
                              );
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<HomeBloc>().add(
                                HomeFetched(),
                              );
                        },
                        child: const Icon(Icons.refresh),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      content,
                    ],
                  ),
                ),
              );
            },
          ),
          DraggableScrollableSheet(
            minChildSize: 0.1,
            initialChildSize: 0.2,
            builder: (context, scrollController) {
              if (!scrollController.hasClients) {
                return ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Container(
                    color: Colors.blue,
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('Item $index'),
                        );
                      },
                    ),
                  ),
                );
              } else {
                if (scrollController.position.viewportDimension > 200) {
                  return ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Container(
                      color: Colors.blue,
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('Item $index'),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Container(
                      color: Colors.blueAccent,
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('Item $index'),
                          );
                        },
                      ),
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
