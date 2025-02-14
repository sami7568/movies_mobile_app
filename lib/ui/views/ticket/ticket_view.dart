import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/app/app.dart';
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
      body: Column(
        children: [],
      ),
    );
  }

  @override
  TicketViewModel viewModelBuilder(BuildContext context) => TicketViewModel();
}
