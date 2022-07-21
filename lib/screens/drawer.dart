import 'package:credicxo_music_app/screens/all_tracks.dart';
import 'package:credicxo_music_app/screens/bookmarked.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Drawer(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: CircleAvatar(
              radius: width * 0.25,
              backgroundImage: const NetworkImage(
                  'https://source.unsplash.com/random/?person,user'),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Ritika Sharma',
            style: TextStyle(fontSize: width * 0.07),
          ),
          Text(
            'beautifulritika@gmail.com',
            style: TextStyle(fontSize: width * 0.05),
          ),
          const SizedBox(height: 10),
          const Divider(),
          ListTile(
              onTap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => AllTracks())),
              title: Text(
                'Music Library',
                style: TextStyle(fontSize: width * 0.05),
              ),
              leading: const Icon(
                Icons.music_note,
                color: Colors.blue,
              )),
          ListTile(
              onTap: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => BookMarks()),
                  (Route<dynamic> route) => false),
              title: Text(
                'Bookmarks',
                style: TextStyle(fontSize: width * 0.05),
              ),
              leading: const Icon(
                Icons.bookmark,
                color: Colors.red,
              ))
        ]),
      ),
    );
  }
}
