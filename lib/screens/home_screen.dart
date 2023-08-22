import 'package:flutter/material.dart';
import 'package:flutter_movie_app/model/coming_soon_movie_model.dart';
import 'package:flutter_movie_app/model/now_playing_movie_model.dart';
import 'package:flutter_movie_app/model/popular_movie_model.dart';
import 'package:flutter_movie_app/screens/detail_screen.dart';
import 'package:flutter_movie_app/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final Future<List<PopularMovieModel>> popMovieList =
      ApiService().getPoplularMovies();
  final Future<List<NowPlayingMovieModel>> nowPLayingMovieList =
      ApiService().getPlayingMovies();
  final Future<List<ComingSoonMovieModel>> comingMovieList =
      ApiService().getComingMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Popular Movie",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
              FutureBuilder(
                future: popMovieList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                        height: 300,
                        child: (Expanded(
                            flex: 1, child: createPopListView(snapshot))));
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              const SizedBox(
                height: 30,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Now In Cinemas",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
              FutureBuilder(
                future: nowPLayingMovieList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 200,
                      child: (Expanded(
                          flex: 1, child: createNowPlayingListView(snapshot))),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              const SizedBox(
                height: 30,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Coming soon",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
              FutureBuilder(
                future: comingMovieList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 200,
                      child: (Expanded(
                          child: createComingMovieListView(snapshot))),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView createPopListView(AsyncSnapshot<List<PopularMovieModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      separatorBuilder: (context, index) => const SizedBox(
        width: 10,
      ),
      itemBuilder: (context, index) {
        var movie = snapshot.data![index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  id: movie.id,
                ),
                fullscreenDialog: true,
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 300,
            width: 250,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  offset: const Offset(10, 10),
                  color: Colors.black.withOpacity(0.3),
                )
              ],
            ),
            child: (Image.network(movie.posterpath)),
          ),
        );
      },
    );
  }

  ListView createNowPlayingListView(
      AsyncSnapshot<List<NowPlayingMovieModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      separatorBuilder: (context, index) => const SizedBox(
        width: 1,
      ),
      itemBuilder: (context, index) {
        var movie = snapshot.data![index];
        return GestureDetector(
          // onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) {

          //     }),
          //   );
          // },
          child: Container(
              height: 200,
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: const Offset(10, 10),
                    color: Colors.black.withOpacity(0.3),
                  )
                ],
              ),
              child: Image.network(movie.posterpath)),
        );
      },
    );
  }

  ListView createComingMovieListView(
      AsyncSnapshot<List<ComingSoonMovieModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      separatorBuilder: (context, index) => const SizedBox(
        width: 1,
      ),
      itemBuilder: (context, index) {
        var movie = snapshot.data![index];
        return GestureDetector(
          // onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) {

          //     }),
          //   );
          // },
          child: Container(
              height: 300,
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: const Offset(10, 10),
                    color: Colors.black.withOpacity(0.3),
                  )
                ],
              ),
              child: Image.network(movie.posterpath)),
        );
      },
    );
  }
}
