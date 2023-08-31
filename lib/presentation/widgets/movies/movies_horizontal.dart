

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helper/formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesHorizontal extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;
  
  const MoviesHorizontal({super.key, required this.movies, this.title, this.subtitle, this.loadNextPage});

  @override
  State<MoviesHorizontal> createState() => _MoviesHorizontalState();
}

class _MoviesHorizontalState extends State<MoviesHorizontal> {

  final scrollController = ScrollController();

    @override
    void initState() {
      super.initState();
      scrollController.addListener(() { 
        if(widget.loadNextPage == null) return;
        if(scrollController.position.pixels + 100 >= scrollController.position.maxScrollExtent) {
          widget.loadNextPage!();
        }
      });
    }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            if(widget.title != null || widget.subtitle != null) _HeaderTitle(title: widget.title,subtitle: widget.subtitle),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: widget.movies.length,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => FadeInRight(child: _Slide(movie: widget.movies[index])),
              )
            )
          ],
        ),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* Image */
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if ( loadingProgress != null ) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator(strokeWidth: 2 )),
                    );
                  }
                  return FadeIn(child: child);
                },
              ),
            ),
          ),

          /* Votes */

          SizedBox(
            width: 140,
            child: Row(
              children: [
                Icon(Icons.star_half_rounded, color: Colors.yellow.shade800),
                const SizedBox(width: 3),
                
                Text('${movie.voteAverage}', style: textStyles.bodyMedium!.copyWith(color: Colors.yellow.shade800)),
                const Spacer(),
                // const SizedBox(width: 15),
                Text(Formats.formattedNumber(movie.popularity), style: textStyles.bodySmall,)
              ],
            ),
          )

        ]
      )
    );
  }
}

class _HeaderTitle extends StatelessWidget {
  final String? title;
  final String? subtitle;
  
  const _HeaderTitle({ this.title, this.subtitle });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          if(title != null) Text(title!, style: titleStyle),
          const Spacer(),
          if(subtitle != null) 
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: (){}, 
              child: Text(subtitle!)
            )
        ],
      ),
    );
  }
}