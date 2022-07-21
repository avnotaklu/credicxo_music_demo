// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'tracks_bloc.dart';

abstract class TracksState extends Equatable {
  final List<Object> stateVars;
  const TracksState(this.stateVars);

  @override
  List<Object> get props => stateVars;
}

// Initial is also loading state
class TracksInitialState extends TracksState {
  TracksInitialState() : super([]);
}

class TracksLoadedState extends TracksState {
  final List<Track> tracks;
  TracksLoadedState({
    required this.tracks,
  }) : super([tracks]);
}

class ClickedTrackState extends TracksState {
  final int id;
  ClickedTrackState(this.id) : super([id]);
}

class TracksLoadingErrorState extends TracksState {
  TracksLoadingErrorState() : super([]);
}
