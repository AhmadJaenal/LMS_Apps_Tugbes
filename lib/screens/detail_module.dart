import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/services/query_collection.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../shared/theme.dart';

class DetailModule extends StatefulWidget {
  final String titleModule;
  final String dsc;
  final String fileName;
  final String url;
  const DetailModule({
    super.key,
    required this.titleModule,
    required this.dsc,
    required this.fileName,
    this.url = '',
  });

  @override
  State<DetailModule> createState() => _DetailModuleState();
  void initState() {
    // Mengatur preferensi orientasi layar
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, // Potrait mode
      DeviceOrientation.landscapeLeft, // Landscape mode
      DeviceOrientation.landscapeRight, // Landscape mode
    ]);
  }
}

@override
void dispose() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class _DetailModuleState extends State<DetailModule> {
  // YoutubePlayerController ytController = YoutubePlayerController(
  //   initialVideoId: '45hGjT2xOA8',
  //   flags: YoutubePlayerFlags(
  //     autoPlay: true,
  //     mute: true,
  //   ),
  // );
  bool isDownload = false;
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: blueColor,
                    ),
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: whiteColor,
                      size: 16,
                    ),
                  ),
                ),
                Text(
                  widget.titleModule,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  blurRadius: 50,
                  offset: const Offset(0, 0),
                  color: secondaryColor.withOpacity(.13),
                ),
              ],
            ),
            child:
                Text(widget.dsc, style: Theme.of(context).textTheme.bodyMedium),
          ),
          const SizedBox(height: 24),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  blurRadius: 50,
                  offset: const Offset(0, 0),
                  color: secondaryColor.withOpacity(.13),
                ),
              ],
            ),
            child: Row(
              children: [
                SvgPicture.asset('assets/pdf.svg', width: 24),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    // Get.to(PdfView(
                    //   fileName: widget.fileName,
                    //   folderDownload: 'materi',
                    // ));
                    downloadFile(fileUrl: widget.fileName, folder: 'tugas');
                  },
                  child: SizedBox(
                    width: 250,
                    child: Text(
                      widget.fileName,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          widget.url != ""
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Referensi',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: 16),
          widget.url != ''
              ? Container(
                  width: double.infinity,
                  height: 400,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: YTPlayer(url: widget.url),
                )
              : const SizedBox(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class YTPlayer extends StatefulWidget {
  final String url;

  const YTPlayer({Key? key, required this.url}) : super(key: key);

  @override
  _YTPlayerState createState() => _YTPlayerState();
}

class _YTPlayerState extends State<YTPlayer> {
  late YoutubePlayerController _controller;
  bool isFullScreen = false;
  bool _isControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    try {
      _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.url)!,
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
          loop: false,
          isLive: false,
        ),
      );

      _controller.addListener(() {
        if (_controller.value.isFullScreen) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
              overlays: []);
          setState(() {
            isFullScreen = true;
          });
        } else {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
              overlays: []);
          setState(() {
            isFullScreen = false;
          });
        }
      });

      _isControllerInitialized = true;
    } catch (e) {
      _isControllerInitialized = false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isControllerInitialized) {
      return WillPopScope(
        onWillPop: () async {
          if (isFullScreen) {
            _controller.toggleFullScreenMode();
            return false;
          }
          return true;
        },
        child: Scaffold(
          body: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: primaryColor,
              progressColors: ProgressBarColors(backgroundColor: Colors.grey),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Column(
            children: [
              SvgPicture.asset('assets/error.svg', width: 200),
              Text(
                'Vidio tidak ditemukan',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      );
    }
  }
}
