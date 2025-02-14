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
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: viewModel.currentIndex,
        onTap: viewModel.changeIndex,
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}

/// Custom Bottom Navigation Bar
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar(
      {Key? key, required this.currentIndex, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(27.r),
      child: BottomNavigationBar(
        backgroundColor: kcVoilet,
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: kcGrayishPurple,
        selectedLabelStyle: _navTextStyle(Colors.white),
        unselectedLabelStyle: _navTextStyle(kcGrayishPurple),
        items: [
          BottomNavItem(
              iconPath: "assets/dashboard_icon.svg",
              label: "Dashboard",
              index: 0,
              currentIndex: currentIndex),
          BottomNavItem(
              iconPath: "assets/play_icon.svg",
              label: "Watch",
              index: 1,
              currentIndex: currentIndex),
          BottomNavItem(
              iconPath: "assets/more_icon.svg",
              label: "Media Library",
              index: 2,
              currentIndex: currentIndex),
          BottomNavItem(
              iconPath: "assets/menu_icon.svg",
              label: "More",
              index: 3,
              currentIndex: currentIndex),
        ],
      ),
    );
  }

  TextStyle _navTextStyle(Color color) {
    return GoogleFonts.roboto(
      fontSize: 10.sp,
      color: color,
      fontWeight: FontWeight.w700,
      height: 1,
    );
  }
}

/// Bottom Navigation Item
class BottomNavItem extends BottomNavigationBarItem {
  BottomNavItem({
    required String iconPath,
    required String label,
    required int index,
    required int currentIndex,
  }) : super(
          icon: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                iconPath,
                color: currentIndex == index ? Colors.white : kcGrayishPurple,
              ),
              SizedBox(height: 8.h),
            ],
          ),
          label: label,
        );
}
