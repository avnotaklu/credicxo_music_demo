part of 'track_lyrics_bloc.dart';

abstract class TrackLyricsState extends Equatable {
  final List<Object> stateVars;
  const TrackLyricsState(this.stateVars);

  @override
  List<Object> get props => stateVars;
}

class TrackLyricsInitialState extends TrackLyricsState {
  TrackLyricsInitialState() : super([]);
}

class TrackLyricsLoadedState extends TrackLyricsState {
  final Lyrics lyrics;
  TrackLyricsLoadedState({
    required this.lyrics,
  }) : super([lyrics]);
}

class TrackLyricsLoadingErrorState extends TrackLyricsState {
  TrackLyricsLoadingErrorState() : super([]);
}
