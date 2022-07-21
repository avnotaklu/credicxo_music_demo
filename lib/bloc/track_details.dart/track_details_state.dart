part of 'track_details_bloc.dart';

abstract class TrackDetailsState extends Equatable {
  final List<Object> stateVars;
  const TrackDetailsState(this.stateVars);

  @override
  List<Object> get props => stateVars;
}

// Initial is also loading state
class TrackDetailsInitialState extends TrackDetailsState {
  TrackDetailsInitialState() : super([]);
}

class TrackDetailsLoadedState extends TrackDetailsState {
  final Track track;
  final bool trackBookmarked;
  TrackDetailsLoadedState({
    required this.trackBookmarked,
    required this.track,
  }) : super([track, trackBookmarked]);
}

class TrackDetailsLoadingErrorState extends TrackDetailsState {
  TrackDetailsLoadingErrorState() : super([]);
}
