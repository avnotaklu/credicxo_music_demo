class BookMarkedTrack {
  int? trackId;
  String? trackName;
  int? trackRating;
  int? albumId;
  String? albumName;
  int? artistId;
  String? artistName;

  BookMarkedTrack({
    this.trackId,
    this.trackName,
    this.trackRating,
    this.albumId,
    this.albumName,
    this.artistId,
    this.artistName,
  });

  BookMarkedTrack.fromJson(Map<String, dynamic> json) {
    trackId = json['track_id'];
    trackName = json['track_name'];
    trackRating = json['track_rating'];
    albumId = json['album_id'];
    albumName = json['album_name'];
    artistId = json['artist_id'];
    artistName = json['artist_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['track_id'] = this.trackId;
    data['track_name'] = this.trackName;
    data['track_rating'] = this.trackRating;
    data['album_id'] = this.albumId;
    data['album_name'] = this.albumName;
    data['artist_id'] = this.artistId;
    data['artist_name'] = this.artistName;
    return data;
  }
}
