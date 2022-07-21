part of 'tracks_bloc.dart';

abstract class TracksEvent extends Equatable {
  final List<Object> stateVars;
  const TracksEvent(this.stateVars);

  @override
  List<Object> get props => stateVars;
}

class TracksLoading extends TracksEvent {
  TracksLoading() : super([]);
}

class ClickTrack extends TracksEvent {
  final int id;

  ClickTrack(this.id) : super([id]);
}
