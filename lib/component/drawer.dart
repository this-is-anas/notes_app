import 'package:flutter/material.dart';
import 'package:note_app/component/drawer_tile.dart';
import 'package:note_app/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          //Header
          DrawerHeader(child: Icon(Icons.edit)),

          //Notes Tile
          DrawerTile(title: "Notes", leading: Icon(Icons.home), onTap: () => Navigator.pop(context)),

          //Settings TIle
          DrawerTile(
              title: "Settings", leading: Icon(Icons.settings), onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(),));
          }),
        ],
      ),
    );
  }
}
