import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../main/cubit/video_cubit.dart'; // pastikan ini diimport

class ThemaVideoScreen extends StatefulWidget {
  const ThemaVideoScreen({super.key});

  @override
  State<ThemaVideoScreen> createState() => _ThemaVideoScreenState();
}

class _ThemaVideoScreenState extends State<ThemaVideoScreen> {
  late YoutubePlayerController _controller;
  final List<Map<String, String>> videoList = [
    {
      "title": "Rivalitas F1",
      "url":
          "https://www.youtube.com/watch?v=dlma-jdrNKY&ab_channel=GhifariAliza2",
    },
    {
      "title": "F1 Ferrari",
      "url":
          "https://www.youtube.com/watch?v=q-kFyhYNI_Y&t=1270s&ab_channel=ARVIGOLDENBOY",
    },
    {
      "title": "F1 Tersengit",
      "url":
          "https://www.youtube.com/watch?v=7RwtrLSsVjE&ab_channel=PublicbarbarOfficial",
    },
    {
      "title": "F1 Paling Canggih",
      "url":
          "https://www.youtube.com/watch?v=-gP4JD5m_Gk&ab_channel=GBBBUSSUOSS",
    },
  ];

  @override
  void initState() {
    super.initState();
    final initialId = YoutubePlayer.convertUrlToId(videoList[0]['url']!)!;
    _controller = YoutubePlayerController(
      initialVideoId: initialId,
      flags: const YoutubePlayerFlags(autoPlay: false),
    );
  }

  void _loadAndPlayVideo(String url, BuildContext context) {
    final videoId = YoutubePlayer.convertUrlToId(url);
    if (videoId != null) {
      _controller.load(videoId);
      context.read<VideoCubit>().changeVideo(videoId);
    }
  }

  Widget _buildVideoList(BuildContext context, String activeVideoId) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          videoList.map((video) {
            final videoId = YoutubePlayer.convertUrlToId(video['url']!)!;
            final isActive = videoId == activeVideoId;

            return InkWell(
              onTap: () => _loadAndPlayVideo(video['url']!, context),
              child: Card(
                color: isActive ? const Color(0xFFE0F2F1) : null,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: Icon(
                    Icons.play_circle_fill,
                    color: isActive ? Colors.green : Colors.red,
                  ),
                  title: Text(
                    video['title']!,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isActive ? Colors.teal : null,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
            );
          }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              VideoCubit()..changeVideo(
                YoutubePlayer.convertUrlToId(videoList[0]['url']!)!,
              ),
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(controller: _controller),
        builder: (context, player) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Video Kajian"),
              leading: const BackButton(),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  player,
                  const SizedBox(height: 24),
                  const Text(
                    "Video Lainnya",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  BlocBuilder<VideoCubit, String>(
                    builder:
                        (context, activeId) =>
                            _buildVideoList(context, activeId),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
