part of 'internet_connectivity_bloc.dart';

abstract class InternetConnectivityEvent extends Equatable {
  final List<Object> stateVars;
  const InternetConnectivityEvent(this.stateVars);

  @override
  List<Object> get props => stateVars;
}

class InternetConnectionChangeEvent extends InternetConnectivityEvent {
  final bool hasConnection;
  InternetConnectionChangeEvent(this.hasConnection) : super([hasConnection]);
}

class InternetConnectionLoadingEvent extends InternetConnectivityEvent {
  final bool hasConnection;
  InternetConnectionLoadingEvent(this.hasConnection) : super([hasConnection]);
}

class InternetErrorEvent extends InternetConnectivityEvent {
  InternetErrorEvent() : super([]);
}
