import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';

import 'movie_detail_viewmodel.dart';

class MovieDetailView extends StackedView<MovieDetailViewModel> {
  const MovieDetailView({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  Widget builder(
      BuildContext context, MovieDetailViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: Builder(builder: (context) {
        return FutureBuilder(
            future: viewModel.fetchMovieDetail(id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    snapshot.data?.backdropUrl ?? ""),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black,
                                    Colors.black.withOpacity(0),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Column(
                              children: [
                                Container(
                                  height: 95.h,
                                  padding: EdgeInsets.only(
                                      top: 50.h, left: 24.w, bottom: 10.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        visualDensity:
                                            const VisualDensity(vertical: -4),
                                        padding: EdgeInsets.zero,
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.white,
                                          size: 20.sp,
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Text(
                                        "Watch",
                                        style: GoogleFonts.poppins(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            height: 1,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),

                                const Spacer(),

                                ///
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 20.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        snapshot.data?.tagline ?? "",
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      Text(
                                        snapshot.data?.title ?? "",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          height: 20 / 16,
                                        ),
                                      ),
                                      SizedBox(height: 15.h),
                                      OutlinedButton(
                                          onPressed: () {},
                                          style: OutlinedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            fixedSize: Size(243.w, 50.h),
                                            side: const BorderSide(
                                              color: kcBabyBlue,
                                            ),
                                            backgroundColor: kcBabyBlue,
                                          ),
                                          child: Text(
                                            "Get Tickets",
                                            style: GoogleFonts.poppins(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          )),
                                      SizedBox(height: 10.h),
                                      OutlinedButton.icon(
                                        onPressed: () {
                                          viewModel.navigateToTrailer(
                                              snapshot.data!.id);
                                        },
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          side: const BorderSide(
                                              color: kcBabyBlue, width: 1),
                                          // maximumSize: Size(),
                                          fixedSize: Size(243.w, 50.h),
                                        ),
                                        icon: const Icon(
                                          Icons.play_arrow,
                                          color: Colors.white,
                                        ),
                                        label: Text(
                                          "Watch Trailer",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    ///
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.h, vertical: 27.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Genres",
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: ktextColor,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Wrap(
                            children: [
                              if (snapshot.data?.genres != null)
                                ...snapshot.data!.genres.map((genre) => Padding(
                                      padding: EdgeInsets.only(right: 5.h),
                                      child: _generesChip(genre.name,
                                          _getGenreColor(genre.name)),
                                    )),
                            ],
                          ),
                          SizedBox(height: 22.h),
                          const Divider(color: kcGreytextColor),
                          SizedBox(height: 15.h),
                          Text(
                            "Overview",
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: ktextColor,
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            snapshot.data?.overview ?? "",
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: kcGreytextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            });
      }),
    );
  }

  // Color _getGenreColor(String genre) {
  //   switch (genre.toLowerCase()) {
  //     case "thriller":
  //       return kcPinkishMagenta;
  //     case "science":
  //       return kcroyalPurple;
  //     case "fiction":
  //       return kcGoldenMustardYellow;
  //     case "action":
  //       return kcAquaGreen;
  //     default:
  //       return kcVoilet; // Set a default color
  //   }
  // }

  Color _getGenreColor(String text) {
    final int hash = text.codeUnits.fold(0, (prev, elem) => prev + elem);
    final Random random = Random(hash);

    return Color.fromARGB(
      255,
      50 + random.nextInt(100), // Red (50-150)
      50 + random.nextInt(100), // Green (50-150)
      50 + random.nextInt(100), // Blue (50-150)
    );
  }

  _generesChip(String title, Color color) {
    return Chip(
      label: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      backgroundColor: color,
    );
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
