// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tracks_bloc.dart';

abstract class TracksEvent extends Equatable {
  final List<Object> stateVars;
  const TracksEvent(this.stateVars);

  @override
  List<Object> get props => stateVars;
}

class TracksLoadingEvent extends TracksEvent {
  TracksLoadingEvent() : super([]);
}

