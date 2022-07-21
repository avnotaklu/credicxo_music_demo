import 'package:credicxo_music_app/bloc/all_tracks.dart/tracks_bloc.dart';
import 'package:credicxo_music_app/bloc/bookmarks/bookmarks_bloc.dart';
import 'package:credicxo_music_app/bloc/internet_connectivity/internet_connectivity_bloc.dart';
import 'package:credicxo_music_app/bloc/track_details.dart/track_details_bloc.dart';
import 'package:credicxo_music_app/bloc/track_lyrics/track_lyrics_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackDetails extends StatelessWidget {
  const TrackDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final trackDetails = BlocProvider.of<TrackDetailsBloc>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Song Details"),
        actions: [
          BlocBuilder<TrackDetailsBloc, TrackDetailsState>(
            builder: (context, state) {
              if (state is TrackDetailsLoadedState) {
                return IconButton(
                    onPressed: () {
                      BlocProvider.of<TrackDetailsBloc>(context).add(
                          TrackBookmarkEvent(
                              state.track, state.trackBookmarked));
                    },
                    icon: state.trackBookmarked
                        ? const Icon(Icons.star)
                        : const Icon(Icons.star_outline));
              } else {
                return Icon(Icons.star_outline);
              }
            },
          )
        ],
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 80, 3, 94),
      ),
      body: BlocBuilder<InternetConnectivityBloc, InternetConnectivityState>(
          builder: (context, state) {
        if ((state is! InternetErrorState)) {
          return BlocBuilder<TrackDetailsBloc, TrackDetailsState>(
            builder: (context, state) {
              if (state is TrackDetailsInitialState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TrackDetailsLoadedState) {
                final track = state.track;
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.01, vertical: height * 0.015),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: height * 0.25,
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.01),
                            child: Card(
                              color: const Color.fromARGB(20, 217, 0, 255),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      'https://source.unsplash.com/random/?song'),
                                                  fit: BoxFit.fill)),
                                          width: width * 0.35,
                                          height: height * 0.18,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: width * 0.5,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: width * 0.4,
                                                    child: Text(
                                                      track.trackName!,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: width * 0.05,
                                                        // color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                      width: width * 0.1,
                                                      child: IconButton(
                                                          onPressed: () {
                                                            // Share.share(
                                                            //     '${track.trackShareUrl}');
                                                          },
                                                          icon: const Icon(
                                                              Icons.ios_share,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      80,
                                                                      3,
                                                                      94)))),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.004,
                                            ),
                                            Container(
                                                width: width * 0.4,
                                                child: Text(
                                                  '${track.artistName} : ${track.albumName}',
                                                  // style: TextStyle(color: Colors.white),
                                                )),
                                            Container(
                                              width: width * 0.4,
                                              child: Text(
                                                'Artist ID : ${track.artistId}',
                                                // style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.4,
                                              child: Text(
                                                'Album ID: ${track.albumId}',
                                                // style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.4,
                                              child: Text(
                                                'Favourites: ${track.numFavourite}',
                                                // style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.03),
                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Artists',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.06),
                                ),
                                SizedBox(height: height * 0.015),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: width * 0.18,
                                      backgroundImage: NetworkImage(
                                          'https://source.unsplash.com/random/?song'),
                                    ),
                                    SizedBox(height: height * 0.01),
                                    Text('${track.artistName}'),
                                  ],
                                ),
                                SizedBox(height: height * 0.03),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Rating',
                                      style: TextStyle(fontSize: width * 0.07),
                                    ),
                                    SizedBox(height: height * 0.008),
                                    Text('${track.trackRating}')
                                  ],
                                ),
                                SizedBox(height: height * 0.03),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Explicit',
                                      style: TextStyle(fontSize: width * 0.07),
                                    ),
                                    SizedBox(height: height * 0.008),
                                    Text('${track.explicit}')
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: height * 0.03),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Primary Genres',
                                  style: TextStyle(fontSize: width * 0.07),
                                ),
                                Container(
                                  height: height * 0.12,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: track
                                        .primaryGenres!.musicGenreList!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.02),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: width * 0.08,
                                              backgroundImage: NetworkImage(
                                                  'https://source.unsplash.com/random/?song'),
                                            ),
                                            Container(
                                              height: height * 0.04,
                                              child: Text(
                                                  '${track.primaryGenres!.musicGenreList![index].musicGenre!.musicGenreName}'),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: height * 0.03),
                                if (track.hasLyrics == 1)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.02),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Lyrics',
                                          style:
                                              TextStyle(fontSize: width * 0.07),
                                        ),
                                        SizedBox(height: height * 0.008),
                                        BlocBuilder<TrackLyricsBloc,
                                            TrackLyricsState>(
                                          builder: (context, state) {
                                            if (state
                                                is TrackLyricsLoadedState) {
                                              return Text(
                                                '${state.lyrics.lyricsBody}',
                                                style: TextStyle(
                                                    fontSize: width * 0.05),
                                              );
                                            } else {
                                              return Container();
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                else
                                  Text("This track doesn't have lyrics")
                              ],
                            ),
                          )
                        ]),
                  ),
                );
              }
              if (state is TrackDetailsLoadingErrorState) {
                return Center(
                  child: Text(
                    "Error Loading data",
                    style: TextStyle(fontSize: 20),
                  ),
                );
              } else {
                return Text("There was an error loading track");
              }
            },
          );
        } else {
          return Scaffold(
            body: Center(
              child: Text(
                "No Internet Connection",
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        }
      }),
    ));
  }
}
