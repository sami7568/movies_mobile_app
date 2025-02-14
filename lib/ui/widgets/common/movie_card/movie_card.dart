import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/models/model_movies.dart';
import 'package:stacked/stacked.dart';

import 'movie_card_model.dart';

class MovieCard extends StackedView<MovieCardModel> {
  const MovieCard({super.key, required this.movie});
  final MoviesModel movie;

  @override
  Widget builder(
      BuildContext context, MovieCardModel viewModel, Widget? child) {
    return Container(
      height: 180.h,
      width: 335.w,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
        image: DecorationImage(
          image: NetworkImage(movie.backdropUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const _Overlay(),
          _MovieTitle(title: movie.title),
        ],
      ),
    );
  }

  @override
  MovieCardModel viewModelBuilder(BuildContext context) => MovieCardModel();
}

/// Widget for displaying the movie background image
class _Overlay extends StatelessWidget {
  const _Overlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        gradient: LinearGradient(
          colors: [Colors.black.withOpacity(0), Colors.black],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}

/// Widget for displaying the movie title
class _MovieTitle extends StatelessWidget {
  final String title;

  const _MovieTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20.h,
      left: 20.w,
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
