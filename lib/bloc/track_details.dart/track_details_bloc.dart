import 'dart:async';

import 'package:credicxo_music_app/bloc/internet_connectivity/internet_connectivity_bloc.dart';
import 'package:credicxo_music_app/model/bookmarked_track.dart';
import 'package:hive/hive.dart';
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
  final int id;
  final InternetConnectivityBloc internetConnectivityBloc;
  late StreamSubscription internetBlocSubscription;
  TrackDetailsBloc(this.internetConnectivityBloc, this.id)
      : super(TrackDetailsInitialState()) {
    internetBlocSubscription = internetConnectivityBloc.stream
        .listen((InternetConnectivityState state) {
      final hasConnection = internetConnectivityBloc
          .checkLoadingStateAndInternetConnection<TrackDetailsInitialState>(
              this.state);
      if (hasConnection) {
        add(TrackDetailsLoadingEvent());
      }
    });

    on<TrackDetailsEvent>((event, emit) async {
      if (event is TrackDetailsLoadingEvent) {
        if (internetConnectivityBloc.checkLoadingStateAndInternetConnection<
            TrackDetailsInitialState>(this.state)) {
          try {
            final track = await fetchTrackFromId(id);
            final bookmarked = await fetchBookmarkedById(id);
            emit(TrackDetailsLoadedState(
                track: track, trackBookmarked: bookmarked));
          } catch (e) {
            emit(TrackDetailsLoadingErrorState());
          }
        }
      }
      if (event is TrackBookmarkEvent) {
        if (event.trackBookmarked) {
          await Hive.box('bookmarks').delete(event.track.trackId);
        } else {
          await Hive.box('bookmarks')
              .put(event.track.trackId, event.track.toJson());
        }
        final bookmarked = await fetchBookmarkedById(id);
        emit(TrackDetailsLoadedState(
            track: event.track, trackBookmarked: bookmarked));
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

  Future<bool> fetchBookmarkedById(int trackId) async {
    final bookmarksDatastore = Hive.box('bookmarks');
    final track = ((await bookmarksDatastore.get(trackId)));
    return track?.isNotEmpty ?? false;
  }

  @override
  Future<void> close() {
    internetBlocSubscription.cancel();
    return super.close();
  }
}
