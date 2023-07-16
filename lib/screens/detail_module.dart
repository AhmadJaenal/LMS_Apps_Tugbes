import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms_app_tugbes/services/query_collection.dart';
import 'package:lms_app_tugbes/screens/pdf_view.dart';

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
}

class _DetailModuleState extends State<DetailModule> {
  @override
  bool isDownload = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SizedBox(height: 60),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
            const SizedBox(height: 32),
            Container(
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
              child: Text(widget.dsc,
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
            const SizedBox(height: 24),
            Container(
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
                      Get.to(PdfView(fileName: widget.fileName));
                      downloadFile(fileUrl: widget.fileName, folder: 'materi');
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

            // widget.url != ""
            //     ? Text(
            //         'Referensi',
            //         style: Theme.of(context).textTheme.bodyMedium,
            //       )
            //     : const SizedBox(),
            // const SizedBox(height: 16),
            // widget.url != ''
            //     ? Container(
            //         width: double.infinity,
            //         height: 200,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         child: YTPlayer(url: widget.url),
            //       )
            //     : const SizedBox(),
          ],
        ),
      ),
    );
  }
}



// class YTPlayer extends StatefulWidget {
//   final String url;

//   const YTPlayer({Key? key, required this.url}) : super(key: key);

//   @override
//   _YTPlayerState createState() => _YTPlayerState();
// }

// class _YTPlayerState extends State<YTPlayer> {
//   late YoutubePlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = YoutubePlayerController(
//       initialVideoId: YoutubePlayer.convertUrlToId(widget.url)!,
//       flags: const YoutubePlayerFlags(
//         mute: false,
//         autoPlay: false,
//         loop: false,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: YoutubePlayer(
//           controller: _controller,
//           showVideoProgressIndicator: true,
//           progressIndicatorColor: blueColor,
//           progressColors: ProgressBarColors(backgroundColor: secondaryColor),
//         ),
//       ),
//     );
//   }
// }
