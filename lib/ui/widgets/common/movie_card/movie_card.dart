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
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0),
            Colors.black,
          ],
          begin: Alignment.center,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
        image: DecorationImage(
          image: NetworkImage(movie.backdropUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 70.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0),
                    Colors.black,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20.h,
            left: 20.w,
            child: Text(
              movie.title,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  MovieCardModel viewModelBuilder(BuildContext context) => MovieCardModel();
}
