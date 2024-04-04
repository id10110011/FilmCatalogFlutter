import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_catalog_flutter/models/movie.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final Movie movie;
  const CardItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Card(
            elevation: 15,
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              height: 230,
              width: 160,
              fit: BoxFit.fitWidth,
              imageUrl: movie.pictures.isNotEmpty
                  ? movie.pictures[0]
                  : "https://st.kinobase.org/storage/360x534/posters/2024/03/da299c96aeb86151e9b1.jpg",
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: Text(
              movie.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
    );
  }
}