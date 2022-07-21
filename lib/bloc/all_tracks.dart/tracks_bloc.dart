import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:credicxo_music_app/model/music_match_model/all_tracks_body.dart';
import 'package:credicxo_music_app/model/music_match_model/music_match_response.dart';
import 'package:credicxo_music_app/model/music_match_model/single_track_body.dart';
import 'package:credicxo_music_app/model/track.dart';
import 'package:credicxo_music_app/services/api.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'tracks_event.dart';
part 'tracks_state.dart';

class TracksBloc extends Bloc<TracksEvent, TracksState> {
  TracksBloc() : super(TracksInitialState()) {
    on<TracksEvent>((event, emit) async {
      if (event is TracksLoading) {
        final tracks = await fetchAllTracks();
        emit(TracksLoadedState(tracks: tracks));
      }
      if (event is ClickTrack) {
        emit(ClickedTrackState(event.id));
      }
    });
  }

  Future<List<Track>> fetchAllTracks() async {
    return (MusicMatchResponse<AllTrackBody>.fromJson(
                json.decode(
                    (await http.get(Uri.parse(MusicMatchApi.allTracks))).body),
                AllTrackBody.bodyParser)
            .message
            ?.body as AllTrackBody)
        .allTracks!;
  }
}
