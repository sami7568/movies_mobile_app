import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/models/model_movies.dart';
import 'package:movies_app/ui/common/app_colors.dart';
import 'package:movies_app/ui/views/movie_detail/movie_detail_view.dart';
import 'package:movies_app/ui/widgets/common/network_image/network_image.dart';
import 'package:stacked/stacked.dart';
import 'search_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      viewModelBuilder: () => SearchViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: kcGhostWhite,
          body: SafeArea(
            child: Column(
              children: [
                // SearchAppBar(viewModel: viewModel, context: context),
                _buildSearchBar(viewModel, context),
                Expanded(
                  child: viewModel.isBusy
                      ? const Center(child: CircularProgressIndicator())
                      : viewModel.searchFinalized
                          ? _buildFinalResults(viewModel, context)
                          : _buildSuggestions(viewModel, context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// ✅ Search Bar UI (No Blue Border)
  Widget _buildSearchBar(SearchViewModel viewModel, BuildContext context) {
    return Column(children: [
      Container(
        width: 334.w,
        height: 52.h,
        decoration: BoxDecoration(
          color: kcGhostWhite,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: TextField(
          onChanged: (query) => viewModel.searchMovies(query),
          onSubmitted: (_) => viewModel.finalizeSearch(),
          autofocus: true,
          style: TextStyle(fontSize: 16.sp),
          decoration: InputDecoration(
            hintText: "TV shows, movies and more",
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 15.w, right: 10.w),
              child: const Icon(
                Icons.search,
              ),
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.close),

              ///clear text field
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
    ]);
  }

  ///  Live Search Suggestions (List View)
  Widget _buildSuggestions(SearchViewModel viewModel, BuildContext context) {
    return viewModel.searchQuery.isEmpty
        ? _buildGridView(viewModel, context) // Show grid if search is empty
        : _buildListView(viewModel.filteredMovies, context);
  }

  /// Final Search Results (List View)
  Widget _buildFinalResults(SearchViewModel viewModel, BuildContext context) {
    return _buildListView(viewModel.finalResults, context);
  }

  /// Grid View (Shows all movies initially) with Fixed Height
  Widget _buildGridView(SearchViewModel viewModel, BuildContext context) {
    double aspectRatio = 163.w / 100.h; // ✅ Dynamically calculated
    return GridView.builder(
      padding: EdgeInsets.all(15.w),
      itemCount: viewModel.filteredMovies.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: aspectRatio,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final movie = viewModel.filteredMovies[index];
        return GestureDetector(
          onTap: () => _navigateToDetail(context, movie),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Stack(
              children: [
                NetworkImageWidget(
                  url: movie.backdropUrl,
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                ),
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
                  left: 10.w,
                  child: Text(
                    movie.title,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// List View (For Live Suggestions & Final Search Results) with Fixed Height
  Widget _buildListView(List<MoviesModel> movies, BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(top: 15.h),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return SizedBox(height: 100.h, child: _itemWidget(context, movie));
      },
      separatorBuilder: (BuildContext context, int index) => 20.verticalSpace,
    );
  }

  _itemWidget(BuildContext context, MoviesModel movie) {
    return InkWell(
      onTap: () {
        _navigateToDetail(context, movie);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: NetworkImageWidget(
                url: movie.posterUrl,
                height: 100.h,
                width: 130.w,
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
              ),
            ),
            21.horizontalSpace,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  5.verticalSpace,
                  Text(movie.title,
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: kcDarkGreyColor,
                      )),
                  Text(movie.title,
                      maxLines: 2,
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xffDBDBDF),
                      )),
                  5.verticalSpace,
                  5.verticalSpace,
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  ///show menu
                },
                icon: const Icon(
                  Icons.more_horiz_outlined,
                  color: kcDarkGreyColor,
                ))
          ],
        ),
      ),
    );
  }

  ///  Navigate to Movie Detail Page
  void _navigateToDetail(BuildContext context, MoviesModel movie) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MovieDetailView(id: movie.id)),
    );
  }
}
