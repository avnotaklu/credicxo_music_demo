import 'package:credicxo_music_app/bloc/all_tracks.dart/tracks_bloc.dart';
import 'package:credicxo_music_app/bloc/track_details.dart/track_details_bloc.dart';
import 'package:credicxo_music_app/model/track.dart';
import 'package:credicxo_music_app/screens/track_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllTracks extends StatefulWidget {
  const AllTracks({Key? key}) : super(key: key);

  @override
  _AllTracksState createState() => _AllTracksState();
}

class _AllTracksState extends State<AllTracks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<TracksBloc>(
        create: (context) => TracksBloc()..add(TracksLoading()),
        child: Container(
          child: BlocConsumer<TracksBloc, TracksState>(
            listener: (context, state) {
              if (state is ClickedTrackState) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return BlocProvider<TrackDetailsBloc>(
                    create: (context) => TrackDetailsBloc()
                      ..add(TrackDetailsLoadingEvent(state.id)),
                    child: TrackDetails(),
                  );
                }));
              }
            },
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
              return Container();
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

  final Track track;

  @override
  Widget build(BuildContext context) {
    final tracksBloc = BlocProvider.of<TracksBloc>(context);
    return ListTile(
      onTap: () => tracksBloc.add(ClickTrack(track.trackId!)),
      leading: Text((track.trackId!).toString()),
      title: Text(track.trackName!),
      subtitle: Text(track.albumName!),
    );
  }
}
