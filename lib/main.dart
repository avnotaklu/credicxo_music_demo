import 'package:credicxo_music_app/bloc/internet_connectivity/internet_connectivity_bloc.dart';
import 'package:credicxo_music_app/screens/all_tracks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final applicationDocumentDir =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(applicationDocumentDir.path);

  await dotenv.load(fileName: ".env");

  await Hive.openBox('bookmarks');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<InternetConnectivityBloc>(
      create: (context) => InternetConnectivityBloc(),
      child: MaterialApp(
        title: 'Credicxo Music App',
        theme: ThemeData(
          fontFamily: "Ubuntu",
          primarySwatch: Colors.blue,
        ),
        home: AllTracks(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
