part of 'bookmarks_bloc.dart';

abstract class BookmarksEvent extends Equatable {
  final List<Object> stateVars;
  const BookmarksEvent(this.stateVars);

  @override
  List<Object> get props => stateVars;
}

class BookmarksLoadingEvent extends BookmarksEvent {
  BookmarksLoadingEvent() : super([]);

}