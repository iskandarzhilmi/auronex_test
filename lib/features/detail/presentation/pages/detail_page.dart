import 'package:auronex_test/features/home/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/detail_bloc.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.user}) : super(key: key);

  final UserModel user;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailBloc, DetailStateModel>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Form(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Detail Page'),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Edit'),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: widget.user.firstName,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                      ),
                      onChanged: (value) {
                        widget.user.firstName = value;
                      },
                    ),
                    TextFormField(
                      initialValue: widget.user.lastName,
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                      ),
                      onChanged: (value) {
                        widget.user.lastName = value;
                      },
                    ),
                    TextFormField(
                      initialValue: widget.user.email,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      onChanged: (value) {
                        widget.user.email = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
