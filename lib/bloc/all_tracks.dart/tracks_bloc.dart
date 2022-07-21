import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:credicxo_music_app/bloc/internet_connectivity/internet_connectivity_bloc.dart';
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
  final InternetConnectivityBloc internetConnectivityBloc;
  late StreamSubscription internetBlocSubscription;
  TracksBloc(this.internetConnectivityBloc) : super(TracksInitialState()) {
    internetBlocSubscription = internetConnectivityBloc.stream
        .listen((InternetConnectivityState state) {
      final hasConnection = internetConnectivityBloc
          .checkLoadingStateAndInternetConnection<TracksInitialState>(
              this.state);
      if (hasConnection) {
        add(TracksLoadingEvent());
      }
    });

    on<TracksEvent>((event, emit) async {
      if (internetConnectivityBloc.checkLoadingStateAndInternetConnection<
          TracksInitialState>(this.state)) {
        try {
          final tracks = await fetchAllTracks();
          emit(TracksLoadedState(tracks: tracks));
        } catch (e) {
          emit(TracksLoadingErrorState());
        }
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

  @override
  Future<void> close() {
    internetBlocSubscription.cancel();
    return super.close();
  }
}
