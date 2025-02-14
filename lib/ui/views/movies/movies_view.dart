import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/ui/common/app_colors.dart';
import 'package:movies_app/ui/widgets/common/movie_card/movie_card.dart';
import 'package:stacked/stacked.dart';

import 'movies_viewmodel.dart';

class MoviesView extends StackedView<MoviesViewModel> {
  const MoviesView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, MoviesViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 111.h,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Watch",
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff202C43),
                      height: 1.2,
                    ),
                  ),
                  IconButton(
                    visualDensity: const VisualDensity(vertical: -4),
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.search_sharp,
                      color: Colors.black,
                      size: 20.sp,
                    ),
                    onPressed: () {
                      viewModel.navigateToSearchView();
                    },
                  ),
                ],
              ),
            ),

            ///
            FutureBuilder(
                future: viewModel.fetchMovies(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if (snapshot.hasData) {
                    print("data length ${snapshot.data?.length}");
                    return ListView.separated(
                      itemCount: (snapshot.data ?? []).length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top: 30.h),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            viewModel.navigateToMoviesDetailView(
                                snapshot.data![index].id);
                          },
                          child: MovieCard(
                            movie: snapshot.data![index],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 20.h);
                      },
                    );
                  } else {
                    return Container();
                  }
                }),
          ],
        ),
      ),
    );
  }

  @override
  MoviesViewModel viewModelBuilder(BuildContext context) => MoviesViewModel();
}
