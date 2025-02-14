import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';
import 'ticket_viewmodel.dart';

class TicketView extends StackedView<TicketViewModel> {
  const TicketView({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  Widget builder(
      BuildContext context, TicketViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "The King’s Man",
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xff202C43),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "In theaters december 22, 2021",
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: kcBabyBlue,
                height: 1.2,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 26.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Column(
                children: [
                  Text(
                    "Date",
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: ktextColor,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  SizedBox(
                    height: 30.h,
                    child: ListView.separated(
                      itemCount: viewModel.dateList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => 16.horizontalSpace,
                      itemBuilder: (context, index) => InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          viewModel.setSelectedDateIndex(index);
                        },
                        child: Chip(
                          surfaceTintColor: Colors.transparent,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          backgroundColor: viewModel.selectedDateIndex == index
                              ? kcBabyBlue
                              : kcGreyColor.withOpacity(.1),
                          label: Text(
                            viewModel.dateList[index],
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: ktextColor,
                              height: 20 / 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "12:30",
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: ktextColor,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            "Cinetech + hall 1",
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: kcGreytextColor,
                            ),
                          )
                        ],
                      ),
                      // Container(
                      //   width: 99.w,
                      //   height: 145.h,
                      //   child: Column(
                      //     children: [],
                      //   ),
                      // ),
                      SizedBox(height: 10.h),
                      SizedBox(
                        height: 145.h,
                        // width: 375.w,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: 4,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) =>
                              GestureDetector(
                            onTap: () => viewModel.setSelectedHallIndex(index),
                            child: Container(
                              width: 335.w,
                              height: 145.h,
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: viewModel.selectedHallIndex == index
                                      ? kcBabyBlue
                                      : kcGreyColor,
                                ),
                              ),
                              // child: Row(
                              //   children: [
                              //     Column(
                              //         children: List.generate(
                              //       14,
                              //       (index) => Row(
                              //         children:
                              //             List.generate(3, (index) => const SeatWidget()),
                              //       ),
                              //     )),
                              //     SizedBox(width: 10.w),
                              //     Column(
                              //         children: List.generate(
                              //       14,
                              //       (index) => Row(
                              //         children: List.generate(
                              //             14, (index) => const SeatWidget()),
                              //       ),
                              //     )),
                              //     SizedBox(width: 10.w),
                              //     Column(
                              //         children: List.generate(
                              //       14,
                              //       (index) => Row(
                              //         children:
                              //             List.generate(3, (index) => const SeatWidget()),
                              //       ),
                              //     )),
                              //   ],
                              // )

                              child: Column(
                                children: [
                                  // SizedBox(height: 10.h),
                                  CustomPaint(
                                    painter: UpwardCurveLinePainter(),
                                    child: Container(
                                      // color: kcBabyBlue,
                                      width: 190.w,
                                      height: 16.h,
                                      decoration: const BoxDecoration(),
                                    ),
                                  ),
                                  // SizedBox(height: 10.h),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(14, (rowIndex) {
                                      return Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.h),
                                        child: SeatRow(rowIndex: rowIndex),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(width: 10.w);
                          },
                        ),
                      ),
                      SizedBox(height: 10.h),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: kcGreytextColor,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: "From ",
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color: kcGreytextColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: "50\$",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: kcDarkGreyColor,
                              ),
                            ),
                            const TextSpan(text: " or "),
                            TextSpan(
                              text: "2500",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: kcDarkGreyColor,
                              ),
                            ),
                            const TextSpan(text: " bonus"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Center(
              child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    fixedSize: Size(323.w, 50.h),
                    side: const BorderSide(
                      color: kcBabyBlue,
                    ),
                    backgroundColor: kcBabyBlue,
                  ),
                  child: Text(
                    "Select Seats",
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  @override
  TicketViewModel viewModelBuilder(BuildContext context) => TicketViewModel();
}

class SeatRow extends StatelessWidget {
  final int rowIndex;

  const SeatRow({super.key, required this.rowIndex});

  @override
  Widget build(BuildContext context) {
    int middleSeats = 14;
    int sideSeats = getSideSeats(rowIndex);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Left side seats
        Row(
          children: List.generate(sideSeats, (index) => const SeatWidget()),
        ),
        const SizedBox(width: 20), // Space between side and middle

        // Middle seats (last row has a split)
        if (rowIndex == 13) ...[
          Wrap(
            spacing: 2.58.w,
            children: List.generate(middleSeats, (index) => const SeatWidget()),
          ),
        ] else ...[
          Wrap(
            spacing: 2.58.w,
            children: List.generate(middleSeats, (index) => const SeatWidget()),
          ),
        ],
        const SizedBox(width: 20), // Space between middle and side

        // Right side seats
        Row(
          children: List.generate(sideSeats, (index) => const SeatWidget()),
        ),
      ],
    );
  }

  int getSideSeats(int rowIndex) {
    if (rowIndex == 0) return 2;
    if (rowIndex >= 1 && rowIndex <= 3) return 4;
    if (rowIndex >= 4 && rowIndex <= 12) return 5;
    if (rowIndex == 13) return 4;
    return 0;
  }
}

class SeatWidget extends StatelessWidget {
  const SeatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.58.w),
      child: Column(
        children: [
          Container(
            width: 3.07.w,
            height: 2.23.h,
            decoration: BoxDecoration(
              color: kcBabyBlue,
              borderRadius: BorderRadius.circular(.43.r),
            ),
          ),
          SizedBox(height: .15.h),
          Container(
            width: 2.15.w,
            height: 0.46.h,
            decoration: BoxDecoration(
              color: kcBabyBlue,
              borderRadius: BorderRadius.circular(.43.r),
            ),
          ),
        ],
      ),
    );
  }
}

class UpwardCurveLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = kcBabyBlue // Replace with kcBabyBlue if defined
      ..strokeWidth = 2.0 // Set thickness of the line
      ..style = PaintingStyle.stroke;

    final path = Path();

    // Draw only the curved line
    path.moveTo(0, size.height); // Start at the left bottom corner

    // Draw an upward curve (without the straight part)
    path.quadraticBezierTo(size.width / 2, -10, size.width,
        size.height); // Control point adjusted for upward bend

    // Draw the path as a line
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
