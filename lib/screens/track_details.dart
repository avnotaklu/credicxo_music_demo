import 'package:credicxo_music_app/bloc/all_tracks.dart/tracks_bloc.dart';
import 'package:credicxo_music_app/bloc/track_details.dart/track_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackDetails extends StatelessWidget {
  const TrackDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final trackDetails = BlocProvider.of<TrackDetailsBloc>(context);
    return Scaffold(
      body: BlocConsumer<TrackDetailsBloc, TrackDetailsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is TrackDetailsInitialState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TrackDetailsLoadedState) {
            return Container(
              child: Column(
                children: [
                  Text(state.track.trackName!),
                ],
              ),
            );
          } else {
            return Text("There was an error loading track");
          }
        },
      ),
    );
  }
}
