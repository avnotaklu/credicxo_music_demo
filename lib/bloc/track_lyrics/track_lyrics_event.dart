part of 'track_lyrics_bloc.dart';

abstract class TrackLyricsEvent extends Equatable {
  final List<Object> stateVars;
  const TrackLyricsEvent(this.stateVars);

  @override
  List<Object> get props => stateVars;
}

class TrackLyricsLoadingEvent extends TrackLyricsEvent {
  final int id;
  TrackLyricsLoadingEvent(this.id) : super([id]);
}
