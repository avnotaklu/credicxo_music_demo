part of 'track_details_bloc.dart';

abstract class TrackDetailsEvent extends Equatable {
  final List<Object> stateVars;
  const TrackDetailsEvent(this.stateVars);

  @override
  List<Object> get props => stateVars;
}

class TrackDetailsLoadingEvent extends TrackDetailsEvent {
  TrackDetailsLoadingEvent() : super([]);
}

class TrackBookmarkEvent extends TrackDetailsEvent {
  final Track track;
  final bool trackBookmarked;
  TrackBookmarkEvent(this.track, this.trackBookmarked)
      : super([track, trackBookmarked]);
}
