import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'proceed_to_pay_sheet_model.dart';

class ProceedToPaySheet extends StackedView<ProceedToPaySheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const ProceedToPaySheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
      BuildContext context, ProceedToPaySheetModel viewModel, Widget? child) {
    return Container(
      height: 252.h,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 26.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSeatOption("Selected", kcGoldenMustardYellow),
                  SizedBox(height: 15.h),
                  _buildSeatOption("VIP (150\$)", kcVoilet),
                ],
              ),
              SizedBox(width: 55.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSeatOption("Not available", kcGreyColor),
                  SizedBox(height: 15.h),
                  _buildSeatOption("Regular (50 \$)", kcBabyBlue),
                ],
              ),
            ],
          ),
          32.verticalSpace,

          ///
          Container(
            height: 30.h,
            width: 97.h,
            decoration: BoxDecoration(
              color: kcGreyColor.withOpacity(.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: ktextColor,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '4/',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: ktextColor,
                        ),
                      ),
                      TextSpan(
                        text: ' 3 rows',
                        style: GoogleFonts.poppins(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: kcGreyColor,
                        ),
                      ),
                    ],
                  ),
                ),
                // 18.horizontalSpace,
                Text(
                  "X",
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: ktextColor,
                  ),
                )
              ],
            ),
          ),
          32.verticalSpace,

          ///
          Row(
            children: [
              Container(
                  height: 50.h,
                  width: 97.h,
                  decoration: BoxDecoration(
                    color: kcGreyColor.withOpacity(.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Total Price",
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            color: kcDarkGreyColor,
                          ),
                        ),
                        Text(
                          "\$ 50",
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: kcDarkGreyColor,
                          ),
                        ),
                      ],
                    ),
                  )),
              10.horizontalSpace,

              ///
              OutlinedButton(
                  onPressed: () {
                    ///show bottomsheet
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    fixedSize: Size(216.w, 50.h),
                    side: const BorderSide(
                      color: kcBabyBlue,
                    ),
                    backgroundColor: kcBabyBlue,
                  ),
                  child: Text(
                    "Proceed to pay",
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }

  Row _buildSeatOption(String title, Color color) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              width: 17.01.w,
              height: 12.76.h,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 0.85.h),
            Container(
              width: 11.91.w,
              height: 2.25.h,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ],
        ),
        SizedBox(width: 12.84.w),
        Text(
          // "Selected",
          title,
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: kcGreyColor,
            height: 19.2 / 12,
          ),
        )
      ],
    );
  }

  @override
  ProceedToPaySheetModel viewModelBuilder(BuildContext context) =>
      ProceedToPaySheetModel();
}
