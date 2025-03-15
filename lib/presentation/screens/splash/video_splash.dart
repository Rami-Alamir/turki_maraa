import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../../controllers/app_provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/utilities/app_localizations.dart';

class VideoSplash extends StatefulWidget {
  const VideoSplash({super.key});

  @override
  State<VideoSplash> createState() => _VideoSplashState();
}

class _VideoSplashState extends State<VideoSplash> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    context.read<AppProvider>().setLastShownVideo();
    Future.delayed(const Duration(milliseconds: 33000), () async {
      if (!mounted) return;
      navigate();
    });
    _videoController = VideoPlayerController.asset(FixedAssets.video)
      ..initialize().then((_) {
        setState(() {});
      });
    _videoController.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          _videoController.value.isInitialized
              ? Center(
                  child: AspectRatio(
                    aspectRatio: 9 / 16,
                    child: VideoPlayer(
                      _videoController,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          Positioned(
              top: 50,
              left: 50,
              right: 50,
              child: InkWell(
                onTap: () {
                  navigate();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.tr('skip'),
                      style: const TextStyle(
                          color: AppColors.gold,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )),
          // Positioned(
          //     top: 90,
          //     right: 0,
          //     left: 0,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Image.asset(
          //           FixedAssets.logo,
          //           height: 150,
          //           width: 150,
          //         )
          //       ],
          //     )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void navigate() {
    Navigator.of(context).pushNamedAndRemoveUntil(app, (route) => false);
  }
}
