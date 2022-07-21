part of 'track_details_bloc.dart';

abstract class TrackDetailsEvent extends Equatable {
  final List<Object> stateVars;
  const TrackDetailsEvent(this.stateVars);

  @override
  List<Object> get props => stateVars;
}

class ClickGetLyrics extends TrackDetailsEvent {
  final int id;

  ClickGetLyrics(this.id) : super([id]);
}

class TrackDetailsLoadingEvent extends TrackDetailsEvent {
  final int id;
  TrackDetailsLoadingEvent(this.id) : super([id]);
}
