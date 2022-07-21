part of 'internet_connectivity_bloc.dart';

abstract class InternetConnectivityState extends Equatable {
  final List<Object> stateVars;
  const InternetConnectivityState(this.stateVars);

  @override
  List<Object> get props => stateVars;
}

class InternetConnectivityInitial extends InternetConnectivityState {
  InternetConnectivityInitial() : super([]);
}

class InternetConnectionState extends InternetConnectivityState {
  bool hasConnection;
  InternetConnectionState(this.hasConnection) : super([hasConnection]);
}

class InternetErrorState extends InternetConnectivityState {
  InternetErrorState() : super([]);
}
