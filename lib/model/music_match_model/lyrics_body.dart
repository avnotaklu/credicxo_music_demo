import 'package:credicxo_music_app/model/lyrics.dart';
import 'package:flutter/cupertino.dart';

import '../model.dart';

class LyricsBody extends Model {
  Lyrics? lyrics;

  LyricsBody({this.lyrics});

  factory LyricsBody.fromJson(Map<String, dynamic> json) {
    return bodyParser(json);
  }
  static LyricsBody bodyParser(Map<String, dynamic> json) {
    return LyricsBody(lyrics: Lyrics.fromJson(json['lyrics']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (lyrics != null) {
      data['lyrics'] = lyrics!.toJson();
    }
    return data;
  }
}
