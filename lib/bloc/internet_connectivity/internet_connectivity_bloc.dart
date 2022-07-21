import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'internet_connectivity_event.dart';
part 'internet_connectivity_state.dart';

class InternetConnectivityBloc
    extends Bloc<InternetConnectivityEvent, InternetConnectivityState> {
  InternetConnectivityBloc() : super(InternetConnectivityInitial()) {
    Connectivity().checkConnectivity().then((value) =>
        add(InternetConnectionChangeEvent(value != ConnectivityResult.none)));

    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        add(InternetConnectionChangeEvent(
            await InternetConnectionChecker().hasConnection));
      } else {
        add(InternetConnectionChangeEvent(false));
      }
    });

    on<InternetConnectivityEvent>((event, emit) async {
      if (event is InternetConnectionChangeEvent) {
        emit(InternetConnectionState(event.hasConnection));
      }
      if (event is InternetErrorEvent) {
        emit(InternetErrorState());
      }
    });
  }

  bool checkLoadingStateAndInternetConnection<T>(loadingState) {
    if (state is InternetConnectionState) {
      if (!(state as InternetConnectionState).hasConnection &&
          loadingState is T) {
        add(InternetErrorEvent());
        return false;
      }
      if (loadingState is! T) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }
}
