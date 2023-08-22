import 'package:flutter/material.dart';
import 'package:flutter_movie_app/model/moive_detail_model.dart';
import 'package:flutter_movie_app/services/api_service.dart';
import 'dart:convert';

class DetailScreen extends StatefulWidget {
  final int id;
  const DetailScreen({
    super.key,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieDetailModel> movie;

  @override
  void initState() {
    super.initState();
    movie = ApiService().getDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text(
          "Detail",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: Column(children: [
        const SizedBox(height: 50),
        FutureBuilder(
          future: movie,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data!.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Container(
                        height: 300,
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
                        child: Image.network(snapshot.data!.poster)),
                    Text(
                      "Rate: ${snapshot.data!.rate}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      "GEnre: ${json.encode(snapshot.data!.genres)}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      snapshot.data!.overview,
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
              );
            }
            return const Text("...");
          },
        )
      ]),
    );
  }
}
