import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:work_report/app/modules/home/home_store.dart';

import 'home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  void initState() {
    super.initState();
    store.loadUserById();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: ValueListenableBuilder(
        valueListenable: store,
        builder: ((context, state, child) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (state is ErrorState) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is LoadedState) {
            return Center(child: ListTile(title: Text(state.user.name)));
          }

          return Container();
        }),
      ),
    );
  }
}
