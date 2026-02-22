import 'package:coursesapp/Courses/cpp/cppinside.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({
    super.key,
    required this.apparTitle,
    required this.videoURL,
    required this.nextpage,
    this.timeStamps = const [],
  });

  final String apparTitle;
  final String videoURL;
  final VoidCallback nextpage;
  final List<Map<String, dynamic>> timeStamps;

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late YoutubePlayerController playerController;
  final Map<String, String> qualityLevels = {
    'auto': 'Auto (Best Available)',
    'highres': 'High Resolution',
    'hd1080': '1080p (Full HD)',
    'hd720': '720p (HD)',
    'large': '480p',
    'medium': '360p',
    'small': '240p',
    'tiny': '144p',
  };

  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(widget.videoURL);
    playerController = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        enableCaption: false,
        captionLanguage: "en",
      ),
    );

    playerController.addListener(() {
      if (!playerController.value.isFullScreen) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      }
    });

    super.initState();
  }

  void jumpToTime(Duration time) {
    playerController.seekTo(time);
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: playerController,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.apparTitle),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Get.offAll(() => const CppCoursePage());
              },
            ),
            actions: [
              PopupMenuButton<String>(
                onSelected: (String quality) {
                  print("Selected Quality: $quality");
                },
                itemBuilder: (BuildContext context) {
                  return qualityLevels.entries.map((entry) {
                    return PopupMenuItem<String>(
                      value: entry.key,
                      child: Text(entry.value),
                    );
                  }).toList();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(Icons.high_quality),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(7),
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 2, color: Colors.blue),
                ),
                child: player,
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(15),
                child: Text(
                  "Time Stamps: ",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 10),
              // Dynamic timestamp buttons
              widget.timeStamps.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: Text("There is no TimeSpaces"),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 12,
                        runSpacing: 15,
                        children: widget.timeStamps.map((stamp) {
                          String label = stamp['label'] ??
                              "${stamp['minutes']}:${stamp['seconds'].toString().padLeft(2, '0')}";
                          return _buildStylishButton(
                            label,
                            () => jumpToTime(
                              Duration(
                                minutes: stamp['minutes'] ?? 0,
                                seconds: stamp['seconds'] ?? 0,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
              const Spacer(),
              GestureDetector(
                onTap: widget.nextpage,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Next",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }
}

Widget _buildStylishButton(String label, VoidCallback onPressed) {
  return Container(
    height: 45,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 5,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: Colors.blue.shade300, width: 2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.timer, size: 18),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    ),
  );
}
