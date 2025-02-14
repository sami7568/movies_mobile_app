import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'video_player_viewmodel.dart';

class VideoPlayerView extends StackedView<VideoPlayerViewModel> {
  const VideoPlayerView({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  Widget builder(
      BuildContext context, VideoPlayerViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: viewModel.isVideoLoading
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  Expanded(
                    child: Center(
                      child: YoutubePlayer(
                        controller: viewModel.controller,
                        showVideoProgressIndicator: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 20.h), // Adjust bottom padding as needed
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: OutlinedButton(
                        onPressed: () {
                          viewModel.setPortraitMood();
                          viewModel.goBack();
                        },
                        child: Text(
                          'Done',
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  VideoPlayerViewModel viewModelBuilder(BuildContext context) =>
      VideoPlayerViewModel();

  @override
  void onViewModelReady(VideoPlayerViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.fetchVideoDetails(id);
  }
}
