import 'package:datas_comemorativas/models/user.dart';
import 'package:datas_comemorativas/provider/users.dart';
import 'package:datas_comemorativas/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTile extends StatefulWidget {
  final User? user;

  const UserTile(
    this.user, {
    Key? key,
  }) : super(key: key);

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    final avatar = widget.user!.avatarurl == null ||
            widget.user!.avatarurl.isEmpty
        ? const CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(widget.user!.avatarurl));
    return ListTile(
        leading: avatar,
        title: Text(widget.user!.name),
        subtitle: Text(widget.user!.email),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.edit),
                color: Colors.grey,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.USER_FORM, arguments: widget.user);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Excluir usuário'),
                      content: const Text('Tem Certeza?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Não'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Sim'),
                        ),
                      ],
                    ),
                  ).then((confirmed) {
                    if (confirmed) {
                      Provider.of<Users>(context, listen: false)
                          .remove(widget.user!);
                    }
                  });
                },
              ),
            ],
          ),
        ));
  }
}
