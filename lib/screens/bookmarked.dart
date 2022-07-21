import 'package:credicxo_music_app/bloc/all_tracks.dart/tracks_bloc.dart';
import 'package:credicxo_music_app/bloc/bookmarks/bookmarks_bloc.dart';
import 'package:credicxo_music_app/bloc/internet_connectivity/internet_connectivity_bloc.dart';
import 'package:credicxo_music_app/bloc/track_details.dart/track_details_bloc.dart';
import 'package:credicxo_music_app/bloc/track_lyrics/track_lyrics_bloc.dart';
import 'package:credicxo_music_app/model/bookmarked_track.dart';
import 'package:credicxo_music_app/model/track.dart';
import 'package:credicxo_music_app/screens/drawer.dart';
import 'package:credicxo_music_app/screens/track_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookMarks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text("Bookmarked"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 80, 3, 94),
      ),
      body: BlocProvider<BookmarksBloc>(
        create: (context) => BookmarksBloc()..add(BookmarksLoadingEvent()),
        child: Container(
          child: BlocConsumer<BookmarksBloc, BookmarksState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is TracksInitialState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is BookmarkLoadedState) {
                if (state.tracks.isEmpty) {
                  return Center(
                    child: Text(
                      "No bookmarks yet",
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }
                return ListView.builder(
                    itemCount: state.tracks.length,
                    itemBuilder: (context, index) {
                      final track = state.tracks[index];
                      return TrackTile(track: track);
                    });
              }
              return Container(
                color: Colors.green,
              );
            },
          ),
        ),
      ),
    );
  }
}

class TrackTile extends StatelessWidget {
  const TrackTile({
    Key? key,
    required this.track,
  }) : super(key: key);

  final BookMarkedTrack track;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<TrackDetailsBloc>(
                    create: (context) => TrackDetailsBloc(
                        BlocProvider.of<InternetConnectivityBloc>(context),
                        track.trackId!)
                      ..add(TrackDetailsLoadingEvent())),
                BlocProvider<TrackLyricsBloc>(
                    create: (context) => TrackLyricsBloc(
                        BlocProvider.of<InternetConnectivityBloc>(context),
                        track.trackId!)
                      ..add(TrackLyricsLoadingEvent(track.trackId!)))
              ],
              child: TrackDetails(),
            );
          }));
          BlocProvider.of<BookmarksBloc>(context).add(BookmarksLoadingEvent());
        },
        title: Text(track.trackName!),
        subtitle: Text(track.artistName!),
        leading: const CircleAvatar(
            radius: 30,
            backgroundImage:
                NetworkImage('https://source.unsplash.com/random/?song')),
      ),
    );
  }
}
