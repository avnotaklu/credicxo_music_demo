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

class TrackDetailsLoadingState extends TrackDetailsState {
  final int id;
  TrackDetailsLoadingState(this.id) : super([id]);
}

class TrackDetailsLoadedState extends TrackDetailsState {
  final Track track;
  TrackDetailsLoadedState({
    required this.track,
  }) : super([track]);
}
