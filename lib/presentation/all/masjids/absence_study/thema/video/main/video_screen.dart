import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/thema/video/cubit/video_cubit.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:masjidku/presentation/all/masjids/absence_study/study/main/cubit/material_asset_cubit.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/study/main/cubit/material_asset_state.dart';

class ThemaVideoScreen extends StatefulWidget {
  final String lectureId;

  const ThemaVideoScreen({super.key, required this.lectureId});

  @override
  State<ThemaVideoScreen> createState() => _ThemaVideoScreenState();
}

class _ThemaVideoScreenState extends State<ThemaVideoScreen> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<LectureSessionMaterialAssetCubit>();
    if (cubit.state is LectureSessionMaterialAssetInitial) {
      cubit.fetchByLectureId(widget.lectureId);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _setupController(String url) {
    final videoId = YoutubePlayer.convertUrlToId(url);
    if (videoId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: false),
      );
      context.read<VideoCubit>().changeVideo(videoId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VideoCubit(),
      child: BlocBuilder<
        LectureSessionMaterialAssetCubit,
        LectureSessionMaterialAssetState
      >(
        builder: (context, state) {
          if (state is LectureSessionMaterialAssetLoading) {
            return Scaffold(
              appBar: AppBar(title: Text("Video Kajian")),
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is LectureSessionMaterialAssetLoaded) {
            final allVideos =
                state.data.where((item) {
                  final url = item.assetFileUrl;
                  return item.type == 'asset' &&
                      item.assetFileType == 1 &&
                      url != null &&
                      YoutubePlayer.convertUrlToId(url) != null;
                }).toList();

            if (allVideos.isEmpty) {
              return Scaffold(
                appBar: AppBar(title: Text("Video Kajian")),
                body: Center(child: Text("Belum ada video.")),
              );
            }

            // Inisialisasi controller jika belum ada
            if (_controller == null) {
              _setupController(allVideos.first.assetFileUrl!);
            }

            return YoutubePlayerBuilder(
              player: YoutubePlayer(controller: _controller!),
              builder: (context, player) {
                return Scaffold(
                  appBar: AppBar(title: const Text("Video Kajian")),
                  body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      children: [
                        player,
                        const SizedBox(height: 24),
                        const Text(
                          "Video Lainnya",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        BlocBuilder<VideoCubit, String>(
                          builder: (context, activeId) {
                            return Column(
                              children:
                                  allVideos.map((video) {
                                    final url = video.assetFileUrl!;
                                    final videoId =
                                        YoutubePlayer.convertUrlToId(url)!;
                                    final isActive = videoId == activeId;

                                    return InkWell(
                                      onTap: () {
                                        _controller?.load(videoId);
                                        context.read<VideoCubit>().changeVideo(
                                          videoId,
                                        );
                                      },
                                      child: Card(
                                        color:
                                            isActive
                                                ? const Color(0xFFE0F2F1)
                                                : null,
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.play_circle_fill,
                                            color:
                                                isActive
                                                    ? Colors.green
                                                    : Colors.red,
                                          ),
                                          title: Text(
                                            video.title,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  isActive ? Colors.teal : null,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return Scaffold(
            appBar: AppBar(title: Text("Video Kajian")),
            body: Center(child: Text("Gagal memuat data.")),
          );
        },
      ),
    );
  }
}
