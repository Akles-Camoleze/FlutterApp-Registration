import 'package:datas_comemorativas/models/user.dart';
import 'package:datas_comemorativas/provider/users.dart';
import 'package:datas_comemorativas/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:datas_comemorativas/components/user_tile.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuários'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.USER_FORM,
                arguments: const User(
                  id: '',
                  name: '',
                  email: '',
                  avatarurl: '',
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (ctx, i) => UserTile(users.byIndex(i)),
      ),
    );
  }
}