import 'package:credicxo_music_app/model/track.dart';

import '../model.dart';

class SingleTrackBody extends Model {
  Track? track;

  SingleTrackBody({this.track});

  factory SingleTrackBody.fromJson(Map<String, dynamic> json) {
    return bodyParser(json);
  }

  static SingleTrackBody bodyParser(Map<String, dynamic> json) {
    SingleTrackBody body =
        SingleTrackBody(track: Track.fromJson(json['track']));
    return body;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.track != null) {
      data['track'] = this.track?.toJson();
    }
    return data;
  }
}
