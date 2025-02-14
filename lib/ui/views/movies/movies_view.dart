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
            const _MoviesHeader(),
            _MoviesList(viewModel: viewModel),
          ],
        ),
      ),
    );
  }

  @override
  MoviesViewModel viewModelBuilder(BuildContext context) => MoviesViewModel();
}

class _MoviesList extends StatelessWidget {
  final MoviesViewModel viewModel;

  const _MoviesList({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: viewModel.fetchMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          final movies = snapshot.data!;
          return ListView.separated(
            itemCount: movies.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 30.h),
            itemBuilder: (context, index) {
              return _MovieItem(
                movie: movies[index],
                onTap: () =>
                    viewModel.navigateToMoviesDetailView(movies[index].id),
              );
            },
            separatorBuilder: (_, __) => SizedBox(height: 20.h),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

/// **Extracted Header Widget**
class _MoviesHeader extends StatelessWidget {
  const _MoviesHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const _SearchButton(),
        ],
      ),
    );
  }
}

/// **Extracted Search Button**
class _SearchButton extends ViewModelWidget<MoviesViewModel> {
  const _SearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, MoviesViewModel viewModel) {
    return IconButton(
      visualDensity: const VisualDensity(vertical: -4),
      padding: EdgeInsets.zero,
      icon: Icon(
        Icons.search_sharp,
        color: Colors.black,
        size: 20.sp,
      ),
      onPressed: viewModel.navigateToSearchView,
    );
  }
}

/// **Extracted Movie Item Widget**
class _MovieItem extends StatelessWidget {
  final dynamic movie;
  final VoidCallback onTap;

  const _MovieItem({required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MovieCard(movie: movie),
    );
  }
}
