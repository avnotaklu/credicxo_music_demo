import 'package:credicxo_music_app/model/model.dart';
import 'package:credicxo_music_app/model/music_match_model/music_match_response.dart';
import 'package:credicxo_music_app/model/track.dart';

class AllTrackBody extends Model {
  List<Track>? allTracks;

  AllTrackBody({this.allTracks});

  factory AllTrackBody.fromJson(Map<String, dynamic> json) {
    return bodyParser(json);
  }

  static AllTrackBody bodyParser(Map<String, dynamic> json) {
    AllTrackBody body = AllTrackBody(allTracks: <Track>[]);
    if (json['track_list'] != null) {
      json['track_list'].forEach((v) {
        body.allTracks!.add(Track.fromJson(v['track']));
      });
    }
    return body;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.allTracks != null) {
      data['track_list'] = this.allTracks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
