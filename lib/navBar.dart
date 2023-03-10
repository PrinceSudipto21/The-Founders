import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("Name"),
            accountEmail: Text("Email ID"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'src',
                  width: 90,
                  height: 90,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
