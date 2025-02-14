import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';
import 'movie_detail_viewmodel.dart';

class MovieDetailView extends StackedView<MovieDetailViewModel> {
  final int id;

  const MovieDetailView({Key? key, required this.id}) : super(key: key);

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
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No data available"));
          }

          final movie = snapshot.data;
          return Column(
            children: [
              _buildHeaderSection(context, movie),
              _buildDetailSection(movie),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, dynamic movie) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          _buildBackgroundImage(movie.backdropUrl),
          _buildGradientOverlay(),
          _buildTopBar(context),
          _buildMovieInfo(movie),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(String? backdropUrl) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(backdropUrl ?? ""),
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
        height: 250.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.black.withOpacity(0)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Positioned(
      top: 50.h,
      left: 24.w,
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20.sp),
          ),
          SizedBox(width: 10.w),
          Text("Watch", style: _sectionTitleStyle()),
        ],
      ),
    );
  }

  Widget _buildMovieInfo(dynamic movie) {
    return Positioned(
      bottom: 20.h,
      left: 0,
      right: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(movie?.tagline ?? "",
              textAlign: TextAlign.center, style: _textStyle(16)),
          SizedBox(height: 6.h),
          Text(movie?.title ?? "",
              textAlign: TextAlign.center, style: _textStyle(16)),
          SizedBox(height: 15.h),
          // _buildActionButton("Get Tickets", kcBabyBlue, () => viewModel.navigateToTickets(movie.id)),
          SizedBox(height: 10.h),
          // _buildActionButton("Watch Trailer", Colors.transparent, () => viewModel.navigateToTrailer(movie.id), Icons.play_arrow),
        ],
      ),
    );
  }

  Widget _buildDetailSection(dynamic movie) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.h, vertical: 27.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Genres", style: _sectionTitleStyle()),
            SizedBox(height: 10.h),
            Wrap(
              children: movie?.genres
                      ?.map<Widget>((genre) =>
                          _genreChip(genre.name, _getGenreColor(genre.name)))
                      ?.toList() ??
                  [],
            ),
            SizedBox(height: 22.h),
            const Divider(color: kcGreytextColor),
            SizedBox(height: 15.h),
            Text("Overview", style: _sectionTitleStyle()),
            SizedBox(height: 15.h),
            Text(movie?.overview ?? "",
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
                style: _textStyle(12)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String title, Color color, VoidCallback onPressed,
      [IconData? icon]) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        side: BorderSide(color: color, width: 1),
        fixedSize: Size(243.w, 50.h),
      ),
      icon: icon != null
          ? Icon(icon, color: Colors.white)
          : const SizedBox.shrink(),
      label: Text(title, style: _textStyle(14)),
    );
  }

  Widget _genreChip(String title, Color color) {
    return Chip(
      label: Text(title, style: _textStyle(12)),
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    );
  }

  Color _getGenreColor(String text) {
    final int hash = text.codeUnits.fold(0, (prev, elem) => prev + elem);
    final Random random = Random(hash);
    return Color.fromARGB(255, 50 + random.nextInt(100),
        50 + random.nextInt(100), 50 + random.nextInt(100));
  }

  TextStyle _sectionTitleStyle() {
    return GoogleFonts.poppins(
        fontSize: 16.sp, fontWeight: FontWeight.w600, color: ktextColor);
  }

  TextStyle _textStyle(double size) {
    return GoogleFonts.poppins(
        fontSize: size.sp, fontWeight: FontWeight.w500, color: Colors.white);
  }

  @override
  MovieDetailViewModel viewModelBuilder(BuildContext context) =>
      MovieDetailViewModel();

  @override
  void onViewModelReady(MovieDetailViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.fetchMovieDetail(id);
  }
}
