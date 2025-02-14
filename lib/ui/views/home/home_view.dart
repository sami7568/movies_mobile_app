import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:movies_app/ui/common/app_colors.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
        backgroundColor: kcBackgroundColor,
        body: viewModel.allScreens[viewModel.currentIndex],
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.circular(27.r),
          child: BottomNavigationBar(
            backgroundColor: kcVoilet,
            currentIndex: viewModel.currentIndex,
            onTap: (val) => viewModel.changeIndex(val),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            unselectedItemColor: kcGrayishPurple,
            selectedLabelStyle: GoogleFonts.roboto(
              fontSize: 10.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
            unselectedLabelStyle: GoogleFonts.roboto(
              fontSize: 10.sp,
              color: kcGrayishPurple,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
            items: [
              buildNavItem(
                iconPath: "assets/dashboard_icon.svg",
                label: "Dashboard",
                index: 0,
                currentIndex: viewModel.currentIndex,
              ),
              buildNavItem(
                iconPath: "assets/play_icon.svg",
                label: "Watch",
                index: 1,
                currentIndex: viewModel.currentIndex,
              ),
              buildNavItem(
                iconPath: "assets/more_icon.svg",
                label: "Media Library",
                index: 2,
                currentIndex: viewModel.currentIndex,
              ),
              buildNavItem(
                iconPath: "assets/menu_icon.svg",
                label: "More",
                index: 3,
                currentIndex: viewModel.currentIndex,
              ),
            ],
          ),
        ));
  }

  // A reusable method to generate the icon with spacing
  Widget buildIconWithSpacing(String iconPath, int index, int currentIndex) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          iconPath,
          color: currentIndex == index ? Colors.white : kcGrayishPurple,
        ),
        SizedBox(height: 8.h),
      ],
    );
  }

  // A reusable method to generate BottomNavigationBarItem
  BottomNavigationBarItem buildNavItem(
      {required String iconPath,
      required String label,
      required int index,
      required int currentIndex}) {
    return BottomNavigationBarItem(
        icon: buildIconWithSpacing(iconPath, index, currentIndex),
        label: label);
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
