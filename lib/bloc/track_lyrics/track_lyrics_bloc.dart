import 'dart:async';
import 'dart:convert';
import 'package:credicxo_music_app/bloc/internet_connectivity/internet_connectivity_bloc.dart';
import 'package:credicxo_music_app/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:credicxo_music_app/bloc/track_details.dart/track_details_bloc.dart';
import 'package:credicxo_music_app/model/lyrics.dart';
import 'package:credicxo_music_app/model/music_match_model/lyrics_body.dart';
import 'package:credicxo_music_app/model/music_match_model/music_match_response.dart';
import 'package:credicxo_music_app/model/music_match_model/single_track_body.dart';
import 'package:credicxo_music_app/model/track.dart';
import 'package:equatable/equatable.dart';

part 'track_lyrics_event.dart';
part 'track_lyrics_state.dart';

class TrackLyricsBloc extends Bloc<TrackLyricsEvent, TrackLyricsState> {
  final InternetConnectivityBloc internetConnectivityBloc;
  late StreamSubscription internetBlocSubscription;

  final int id;
  TrackLyricsBloc(this.internetConnectivityBloc, this.id)
      : super(TrackLyricsInitialState()) {
    internetBlocSubscription = internetConnectivityBloc.stream
        .listen((InternetConnectivityState state) {
      final hasConnection = internetConnectivityBloc
          .checkLoadingStateAndInternetConnection<TrackLyricsInitialState>(
              this.state);
      if (hasConnection) {
        add(TrackLyricsLoadingEvent(id));
      }
    });

    on<TrackLyricsEvent>((event, emit) async {
      if (event is TrackLyricsLoadingEvent) {
        if (internetConnectivityBloc.checkLoadingStateAndInternetConnection<
            TrackLyricsInitialState>(this.state)) {
          try {
            final lyrics = await fetchTrackLyricsFromId(id);
            emit(TrackLyricsLoadedState(lyrics: lyrics));
          } on Exception catch (e) {
            emit(TrackLyricsLoadingErrorState());
          }
        }
      }
    });
  }
  Future<Lyrics> fetchTrackLyricsFromId(int trackId) async {
    return (MusicMatchResponse<LyricsBody>.fromJson(
                json.decode(
                    (await http.get(Uri.parse(MusicMatchApi.lyrics(trackId))))
                        .body),
                LyricsBody.bodyParser)
            .message
            ?.body as LyricsBody)
        .lyrics!;
  }
}
