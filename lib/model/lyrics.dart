class Lyrics {
  int? lyricsId;
  int? explicit;
  String? lyricsBody;
  String? scriptTrackingUrl;
  String? pixelTrackingUrl;
  String? lyricsCopyright;
  String? updatedTime;

  Lyrics(
      {this.lyricsId,
      this.explicit,
      this.lyricsBody,
      this.scriptTrackingUrl,
      this.pixelTrackingUrl,
      this.lyricsCopyright,
      this.updatedTime});

  Lyrics.fromJson(Map<String, dynamic> json) {
    lyricsId = json['lyrics_id'];
    explicit = json['explicit'];
    lyricsBody = json['lyrics_body'];
    scriptTrackingUrl = json['script_tracking_url'];
    pixelTrackingUrl = json['pixel_tracking_url'];
    lyricsCopyright = json['lyrics_copyright'];
    updatedTime = json['updated_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lyrics_id'] = this.lyricsId;
    data['explicit'] = this.explicit;
    data['lyrics_body'] = this.lyricsBody;
    data['script_tracking_url'] = this.scriptTrackingUrl;
    data['pixel_tracking_url'] = this.pixelTrackingUrl;
    data['lyrics_copyright'] = this.lyricsCopyright;
    data['updated_time'] = this.updatedTime;
    return data;
  }
}
