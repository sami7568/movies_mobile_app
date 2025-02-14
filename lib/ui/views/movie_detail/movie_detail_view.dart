import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movies_app/app/app.locator.dart';
import 'package:movies_app/app/app.router.dart';
import 'package:movies_app/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'movie_detail_viewmodel.dart';

class MovieDetailView extends StackedView<MovieDetailViewModel> {
  const MovieDetailView({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  Widget builder(
      BuildContext context, MovieDetailViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: FutureBuilder(
        future: viewModel.fetchMovieDetail(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return Column(
              children: [
                _buildMoviePoster(context, snapshot.data!),
                _buildMovieDetails(context, snapshot.data, viewModel),
              ],
            );
          } else {
            return const Center(child: Text("Failed to load movie details"));
          }
        },
      ),
    );
  }

  Widget _buildMoviePoster(BuildContext context, movie) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      width: double.infinity,
      child: Stack(
        children: [
          _buildBackgroundImage(movie.posterUrl),
          _buildGradientOverlay(),
          _buildHeader(context),
          _buildMovieInfo(movie),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 200.h,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 50.h),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon:
                  Icon(Icons.arrow_back_ios, color: Colors.white, size: 20.sp),
            ),
            SizedBox(width: 10.w),
            Text(
              "Watch",
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieInfo(dynamic movie) {
    return Positioned(
      bottom: 20.h,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Text(
            "In theaters ${_formatDate(movie?.releaseDate ?? "")}",
            style: GoogleFonts.poppins(fontSize: 16.sp, color: Colors.white),
          ),
          SizedBox(height: 15.h),
          _buildActionButton("Get Tickets", kcBabyBlue, () {
            locator<NavigationService>().navigateToTicketView(id: id);
          }),
          SizedBox(height: 10.h),
          _buildActionButton("Watch Trailer", Colors.transparent, () {
            locator<NavigationService>().navigateToVideoPlayerView(id: id);
          }),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, Color color, VoidCallback onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        fixedSize: Size(243.w, 50.h),
        side: const BorderSide(color: kcBabyBlue),
        backgroundColor: color,
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.white),
      ),
    );
  }

  Widget _buildMovieDetails(
      BuildContext context, dynamic movie, MovieDetailViewModel viewModel) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 27.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Genres"),
            Wrap(
              children: movie?.genres
                      ?.map<Widget>((genre) => _buildGenreChip(genre.name))
                      .toList() ??
                  [],
            ),
            SizedBox(height: 22.h),
            const Divider(color: kcGreytextColor),
            _buildSectionTitle("Overview"),
            Text(
              movie?.overview ?? "",
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              style:
                  GoogleFonts.poppins(fontSize: 12.sp, color: kcGreytextColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Text(
        title,
        style: GoogleFonts.poppins(
            fontSize: 16.sp, fontWeight: FontWeight.w600, color: ktextColor),
      ),
    );
  }

  Widget _buildGenreChip(String title) {
    return Padding(
      padding: EdgeInsets.only(right: 5.w),
      child: Chip(
        label: Text(title,
            style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.white)),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        backgroundColor: _getGenreColor(title),
      ),
    );
  }

  String _formatDate(String releaseDate) {
    try {
      return DateFormat('MMMM dd, yyyy').format(DateTime.parse(releaseDate));
    } catch (_) {
      return "Unknown Date";
    }
  }

  Color _getGenreColor(String text) {
    final Random random = Random(text.hashCode);
    return Color.fromARGB(255, 50 + random.nextInt(100),
        50 + random.nextInt(100), 50 + random.nextInt(100));
  }

  @override
  MovieDetailViewModel viewModelBuilder(BuildContext context) =>
      MovieDetailViewModel();
}
