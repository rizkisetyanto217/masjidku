import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/accesoris/border/gap_border_separator.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/main/model/masjid_lecture_sessions_model.dart';
import 'package:share_plus/share_plus.dart';

class MasjidStudyScreen extends StatefulWidget {
  final String lectureSessionId;
  final String masjidSlug;
  final Object? extra;

  const MasjidStudyScreen({
    super.key,
    required this.lectureSessionId,
    required this.masjidSlug,
    this.extra,
  });

  @override
  State<MasjidStudyScreen> createState() => _MasjidStudyScreenState();
}

class _MasjidStudyScreenState extends State<MasjidStudyScreen> {
  MasjidLectureSessionsModel? session;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initSession();
  }

  Future<void> _initSession() async {
    // Coba ambil dari extra
    if (widget.extra is Map<String, dynamic>) {
      final extra = widget.extra as Map<String, dynamic>;
      if (extra['session'] is MasjidLectureSessionsModel) {
        setState(() {
          session = extra['session'];
          isLoading = false;
        });
        return;
      }
    }

    // Jika tidak ada extra -> fetch dari API berdasarkan lectureSessionId
    try {
      final result = await fetchLectureSessionById(widget.lectureSessionId);
      setState(() {
        session = result;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Gagal ambil data kajian: $e");
      setState(() {
        session = null;
        isLoading = false;
      });
    }
  }

  // 🚧 Ganti dengan fungsi API-mu
  Future<MasjidLectureSessionsModel> fetchLectureSessionById(String id) async {
    // Panggil API pakai Dio atau http, lalu parse ke MasjidLectureSessionsModel
    throw UnimplementedError(); // Implementasikan nanti
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Kajian"),
        leading: const BackButton(),
        actions: const [Icon(Icons.more_vert), SizedBox(width: 12)],
        elevation: 0,
      ),
      body: SafeArea(
        child:
            session == null
                ? const Center(child: Text('Data tidak tersedia'))
                : SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KajianInfoSection(
                        data: session!,
                        masjidSlug: widget.masjidSlug,
                      ),
                      const SizedBox(height: 12),
                      const GapBorderSeparator(),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Informasi Kajian",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF006B64),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildTabContent(context, widget.masjidSlug),
                    ],
                  ),
                ),
      ),
    );
  }

  Widget _buildTabContent(BuildContext context, String? masjidSlug) {

    String path(String endpoint) =>
        '/masjid/${masjidSlug ?? "unknown"}/absence-study/study/${widget.lectureSessionId}/$endpoint';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 20,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
        children: [
          _menuItem(
            context,
            Icons.info,
            "Informasi",
            onTap: () => context.push(path("information")),
          ),
          _menuItem(
            context,
            Icons.abc,
            "Latihan Soal",
            onTap: () => context.push(path("quiz")),
          ),
          _menuItem(
            context,
            Icons.people,
            "Transkip Materi",
            onTap: () => context.push(path("transcription")),
          ),
          _menuItem(
            context,
            Icons.calendar_month,
            "Ringkasan",
            onTap: () => context.push(path("summary")),
          ),
          _menuItem(
            context,
            Icons.event_note_sharp,
            "Video Rekaman",
            onTap: () => context.push(path("video")),
          ),
          _menuItem(
            context,
            Icons.workspace_premium,
            "Ajukan Pertanyaan",
            onTap: () => context.push(path("question-user")),
          ),
          _menuItem(
            context,
            Icons.person,
            "Tanya Jawab",
            onTap: () => context.push(path("faq")),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(
    BuildContext context,
    IconData icon,
    String label, {
    int badge = 0,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Icon(icon, size: 40, color: Colors.teal),
              if (badge > 0)
                Positioned(
                  top: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      '$badge',
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class KajianInfoSection extends StatelessWidget {
  final MasjidLectureSessionsModel data;
  final String? masjidSlug;

  const KajianInfoSection({
    super.key,
    required this.data,
    required this.masjidSlug,
  });

  @override
  Widget build(BuildContext context) {
    final title = data.title;
    final teacher = data.teacherName ?? "-";
    final schedule = data.sessionTimeFormatted;
    final grade = data.userGradeResult;
    final status = data.attendanceStatusText ?? "Belum diketahui";

    final shareUrl =
        'https://web-six-theta-13.vercel.app/#/masjid/${masjidSlug ?? "unknown"}/absence-study/study/${data.id}';
    final shareMessage = '''
      Yuk kunjungi kajian menarik di Masjid!

      Materi: $title
      Pengajar: $teacher
      Jadwal: $schedule

      Kunjungi di: $shareUrl
      ''';

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Informasi Kajian",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF006B64),
            ),
          ),
          const SizedBox(height: 8),
          _buildInfoItem(Icons.book_outlined, "Materi : $title"),
          _buildInfoItem(Icons.person_outline, "Pengajar : $teacher"),
          _buildInfoItem(Icons.schedule_outlined, "Jadwal : $schedule"),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatusBox(
                  "Status Kehadiran:\n$status",
                  const Color(0xFFFFA726),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatusBox(
                  "Materi & Soal:\nSudah dikerjakan ✓\nNilai : ${grade ?? '-'}",
                  const Color(0xFF43A047),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: TextButton.icon(
              onPressed: () async {
                await Share.share(shareMessage);
              },
              icon: const Icon(Icons.share, color: Colors.teal),
              label: const Text(
                'Bagikan',
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.black54),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _buildStatusBox(String text, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
