import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('User Name'),
          ),
          Expanded(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  title: Text('Today Tasks'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Text('Next week Tasks'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(title: Text('Costom Deadline'))
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.logout),
            label: Text('Logout'),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
    ;
  }
}