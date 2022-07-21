import 'package:bloc/bloc.dart';
import 'package:credicxo_music_app/model/bookmarked_track.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

part 'bookmarks_event.dart';
part 'bookmarks_state.dart';

class BookmarksBloc extends Bloc<BookmarksEvent, BookmarksState> {
  BookmarksBloc() : super(BookmarksInitial()) {
    on<BookmarksEvent>((event, emit) async {
      emit(BookmarkLoadedState(await fetchBookmarked()));
    });
  }

  Future<List<BookMarkedTrack>> fetchBookmarked() async {
    final bookmarksDatastore = await Hive.openBox('bookmarks');

    return ((Map.from(bookmarksDatastore.toMap()))
        .values
        .toList()
        .map((e) => BookMarkedTrack.fromJson(Map<String, dynamic>.from(e)))
        .toList());
  }
}
