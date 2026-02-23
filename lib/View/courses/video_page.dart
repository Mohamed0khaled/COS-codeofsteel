import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// Video page for playing course videos - migrated from legacy video_page.dart
/// Uses Navigator instead of GetX for navigation
class VideoPage extends StatefulWidget {
  const VideoPage({
    super.key,
    required this.title,
    required this.videoURL,
    required this.onNextPage,
    this.timeStamps = const [],
  });

  final String title;
  final String videoURL;
  final VoidCallback onNextPage;
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
    super.initState();
    final videoID = YoutubePlayer.convertUrlToId(widget.videoURL);
    playerController = YoutubePlayerController(
      initialVideoId: videoID ?? '',
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
  }

  void jumpToTime(Duration time) {
    playerController.seekTo(time);
  }

  void _navigateBack(BuildContext context) {
    Navigator.pop(context);
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
            title: Text(widget.title),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => _navigateBack(context),
            ),
            actions: [
              PopupMenuButton<String>(
                onSelected: (String quality) {
                  debugPrint("Selected Quality: $quality");
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
                child: const Text(
                  "Time Stamps: ",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 10),
              // Dynamic timestamp buttons
              widget.timeStamps.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: Text("There are no timestamps"),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 12,
                        runSpacing: 15,
                        children: widget.timeStamps.map((stamp) {
                          final String label = stamp['label'] ??
                              "${stamp['minutes']}:${stamp['seconds'].toString().padLeft(2, '0')}";
                          return _buildTimestampButton(
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
                onTap: widget.onNextPage,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 30,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 10,
                  ),
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
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimestampButton(String label, VoidCallback onPressed) {
    return SizedBox(
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

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }
}
