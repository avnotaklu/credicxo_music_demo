import 'package:flutter_dotenv/flutter_dotenv.dart';

class MusicMatchApi {
  static String get apiKey => dotenv.env['api_key']!;

  static String get allTracks =>
      "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=$apiKey";
  static String track(int trackId) =>
      "https://api.musixmatch.com/ws/1.1/track.get?track_id=$trackId&apikey=$apiKey";
  static String lyrics(int trackId) =>
      "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$trackId&apikey=$apiKey";
}
