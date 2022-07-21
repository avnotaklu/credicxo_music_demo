part of 'bookmarks_bloc.dart';

abstract class BookmarksState extends Equatable {
  final List<Object> stateVars;
  const BookmarksState(this.stateVars);

  @override
  List<Object> get props => stateVars;
}

class BookmarksInitial extends BookmarksState {
  BookmarksInitial() : super([]);
}

class BookmarkLoadedState extends BookmarksState {
  final List<BookMarkedTrack> tracks;
  BookmarkLoadedState(this.tracks) : super([tracks]);
}
