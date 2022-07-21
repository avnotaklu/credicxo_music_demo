import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:credicxo_music_app/bloc/all_tracks.dart/tracks_bloc.dart';
import 'package:credicxo_music_app/model/music_match_model/music_match_response.dart';
import 'package:credicxo_music_app/model/music_match_model/single_track_body.dart';
import 'package:credicxo_music_app/model/track.dart';
import 'package:credicxo_music_app/services/api.dart';
import 'package:equatable/equatable.dart';

part 'track_details_event.dart';
part 'track_details_state.dart';

class TrackDetailsBloc extends Bloc<TrackDetailsEvent, TrackDetailsState> {
  TrackDetailsBloc() : super(TrackDetailsInitialState()) {
    on<TrackDetailsEvent>((event, emit) async {
      if (event is TrackDetailsLoadingEvent) {
        final track = await fetchTrackFromId(event.id);
        emit(TrackDetailsLoadedState(track: track));
      } else if (event is ClickGetLyrics) {
        // emit()
      }
    });
  }

  Future<Track> fetchTrackFromId(int trackId) async {
    return (MusicMatchResponse<SingleTrackBody>.fromJson(
                json.decode(
                    (await http.get(Uri.parse(MusicMatchApi.track(trackId))))
                        .body),
                SingleTrackBody.bodyParser)
            .message
            ?.body as SingleTrackBody)
        .track!;
  }
}
