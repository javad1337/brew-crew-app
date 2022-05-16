import 'package:brew_crew/screens/home/home.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:provider/provider.dart';

import '../../models/myuser.dart';
import '../../services/database.dart';



class BrewTile extends StatelessWidget {
  //const BrewTile({Key? key, required this.brew}) : super(key: key);
  
  final Brew brew;
  
  BrewTile({required this.brew});

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: SettingsForm(),
        );
      });
    }
    final user = Provider.of<MyUser?>(context);



    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user!.uid).userData,
      builder: (context, snapshot) {

        UserData? userData = snapshot.data;

        return Padding(
          padding: EdgeInsets.only(top: 8),
          child: Card(
            margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/coffee_icon.png'),
                radius: 25,
                backgroundColor: Colors.brown[brew.strength],
              ),
              title: Text(brew.name),
              subtitle: Text('Takes ${brew.sugars} sugar(s)'),
              onTap: () {
                if(brew.name == userData!.name) {
                _showSettingsPanel();
                }
              },
            ),
          ),
        );
      }
    );
  }
}
