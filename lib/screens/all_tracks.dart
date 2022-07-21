import 'package:credicxo_music_app/bloc/all_tracks.dart/tracks_bloc.dart';
import 'package:credicxo_music_app/bloc/internet_connectivity/internet_connectivity_bloc.dart';
import 'package:credicxo_music_app/bloc/track_details.dart/track_details_bloc.dart'
    hide TrackDetailsLoadingErrorState;
import 'package:credicxo_music_app/bloc/track_lyrics/track_lyrics_bloc.dart'
    hide TrackLyricsLoadingErrorState;
import 'package:credicxo_music_app/model/track.dart';
import 'package:credicxo_music_app/screens/drawer.dart';
import 'package:credicxo_music_app/screens/track_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllTracks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text("Most Trending"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 80, 3, 94),
      ),
      body: BlocBuilder<InternetConnectivityBloc, InternetConnectivityState>(
        builder: (context, state) {
          if (!(state is InternetErrorState)) {
            return BlocProvider<TracksBloc>(
              create: (context) =>
                  TracksBloc(BlocProvider.of<InternetConnectivityBloc>(context))
                    ..add(TracksLoadingEvent()),
              child: Container(
                child: BlocConsumer<TracksBloc, TracksState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is TracksInitialState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TracksLoadedState) {
                      return ListView.builder(
                          itemCount: state.tracks.length,
                          itemBuilder: (context, index) {
                            final track = state.tracks[index];
                            return TrackTile(track: track);
                          });
                    }
                    if (state is TracksLoadingErrorState) {
                      return Center(
                        child: Text(
                          "Error Loading data",
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    }
                    return Container(
                      color: Colors.green,
                    );
                  },
                ),
              ),
            );
          } else {
            return Scaffold(
                body: Center(
                    child: Text(
              "No Internet Connection",
              style: TextStyle(fontSize: 20),
            )));
          }
        },
      ),
    );
  }
}

class TrackTile extends StatelessWidget {
  const TrackTile({
    Key? key,
    required this.track,
  }) : super(key: key);

  final Track track;

  @override
  Widget build(BuildContext context) {
    final tracksBloc = BlocProvider.of<TracksBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: () {
          Navigator.of(context)
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
