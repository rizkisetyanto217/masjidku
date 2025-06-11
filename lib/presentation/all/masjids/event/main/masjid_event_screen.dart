// masjid_event_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:masjidku/component/main/home/study/study_card_image.dart';
import 'package:masjidku/component/main/home/study/tab_selector.dart';
import 'package:masjidku/component/main/home/study/thema_list.dart';
import 'package:masjidku/presentation/all/masjids/event/main/cubit/masjid_events_cubit.dart';
import 'package:masjidku/presentation/all/masjids/event/main/cubit/masjid_events_state.dart';
import 'package:masjidku/presentation/all/masjids/event/main/cubit/masjid_event_sessions_cubit.dart';
import 'package:masjidku/presentation/all/masjids/event/main/cubit/masjid_event_sessions_state.dart';

class MasjidEventScreen extends StatelessWidget {
  final String masjidId;
  final String slug; // ⬅️ Tambahkan ini
  const MasjidEventScreen({
    super.key,
    required this.masjidId,
    required this.slug,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  EventSessionsCubit()..loadUpcomingEventSessions(
                    masjidId: masjidId,
                    order: 'terbaru',
                  ),
        ),
        BlocProvider(
          create: (_) => MasjidEventCubit()..fetchEventsByMasjid(masjidId),
        ),
      ],
      child: _MasjidEventScreenBody(masjidId: masjidId, slug: slug),
    );
  }
}

class _MasjidEventScreenBody extends StatefulWidget {
  final String masjidId;
  final String slug;
  const _MasjidEventScreenBody({required this.masjidId, required this.slug});

  @override
  State<_MasjidEventScreenBody> createState() => _MasjidEventScreenBodyState();
}

class _MasjidEventScreenBodyState extends State<_MasjidEventScreenBody> {
  int selectedTab = 0;
  String selectedOrder = 'Terbaru';

  void _onOrderChanged(String order) {
    setState(() => selectedOrder = order);
    context.read<EventSessionsCubit>().loadUpcomingEventSessions(
      masjidId: widget.masjidId,
      order: order,
    );
  }

  void _onTabChanged(int index) {
    setState(() => selectedTab = index);
    if (index == 0) {
      context.read<EventSessionsCubit>().loadUpcomingEventSessions(
        masjidId: widget.masjidId,
        order: selectedOrder,
      );
    }
  }

  String _formatDate(String isoString) {
    try {
      return DateFormat(
        'd MMMM yyyy',
        'id_ID',
      ).format(DateTime.parse(isoString));
    } catch (_) {
      return "Tanggal tidak valid";
    }
  }

  String _formatTime(String isoString) {
    try {
      return DateFormat('HH:mm').format(DateTime.parse(isoString));
    } catch (_) {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acara"),
        leading: const BackButton(),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.more_vert),
          SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabSelector(
              selectedIndex: selectedTab,
              tabs: const [
                {"label": "Terbaru", "icon": Icons.update},
                {"label": "Kategori", "icon": Icons.category},
                {"label": "Bulan", "icon": Icons.calendar_today},
              ],
              onChanged: _onTabChanged,
            ),
            const SizedBox(height: 16),
            if (selectedTab == 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: selectedOrder,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items:
                      ['Terbaru', 'Terlama']
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                  onChanged: (val) {
                    if (val != null) _onOrderChanged(val);
                  },
                ),
              ),
            const SizedBox(height: 16),
            Expanded(
              child: IndexedStack(
                index: selectedTab,
                children: [
                  _buildTerbaruTab(),
                  _buildKategoriTab(),
                  _buildBulanTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTerbaruTab() {
    return BlocBuilder<EventSessionsCubit, EventSessionsState>(
      builder: (context, state) {
        if (state is EventSessionsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is EventSessionsError) {
          return Center(child: Text(state.message));
        }

        if (state is EventSessionsLoaded) {
          final sessions = state.eventSessions;
          if (sessions.isEmpty) {
            return const Center(child: Text('Belum ada acara'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<EventSessionsCubit>().refresh(
                masjidId: widget.masjidId,
                order: selectedOrder,
              );
            },
            child: ListView.separated(
              itemCount: sessions.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final event = sessions[index];
                final date = _formatDate(event.startTime);
                final start = _formatTime(event.startTime);
                final end = _formatTime(event.endTime);

                return StudyCardImage(
                  imageUrl: event.imageUrl,
                  title: event.title,
                  startTime: date,
                  description:
                      '${event.description}\nPukul $start - $end\nLokasi: ${event.location}',
                  onTap: () {
                    context.push(
                      '/masjid/${widget.slug}/event/detail',
                      extra: event, // ✅ INI yang benar
                    );
                  },
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildKategoriTab() {
    return BlocBuilder<MasjidEventCubit, MasjidEventState>(
      builder: (context, state) {
        if (state is MasjidEventLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is MasjidEventError) {
          return Center(child: Text(state.message));
        }
        if (state is MasjidEventLoaded) {
          final categories = _extractCategories(state.events);
          return ListView.separated(
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final category = categories[index];
              final count =
                  state.events
                      .where(
                        (e) => e.eventTitle.toLowerCase().contains(
                          category.toLowerCase(),
                        ),
                      )
                      .length;
              return TemaListCard(
                title: category,
                subtitle: "$count kegiatan",
                onTap: () {},
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildBulanTab() {
    return BlocBuilder<MasjidEventCubit, MasjidEventState>(
      builder: (context, state) {
        if (state is MasjidEventLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is MasjidEventError) {
          return Center(child: Text(state.message));
        }
        if (state is MasjidEventLoaded) {
          final Map<String, int> monthCounts = {};
          for (var event in state.events) {
            final month = DateFormat(
              'MMMM',
              'id_ID',
            ).format(event.eventCreatedAt);
            monthCounts[month] = (monthCounts[month] ?? 0) + 1;
          }
          return ListView.separated(
            itemCount: monthCounts.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final entry = monthCounts.entries.elementAt(index);
              return TemaListCard(
                title: entry.key,
                subtitle: "${entry.value} acara",
                onTap: () {},
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  List<String> _extractCategories(List events) {
    final List<String> unique = [];
    for (var e in events) {
      final title = e.eventTitle.toLowerCase();
      if (title.contains('lomba') && !unique.contains('Lomba & Festival')) {
        unique.add('Lomba & Festival');
      } else if ((title.contains('tabligh') || title.contains('ceramah')) &&
          !unique.contains('Tabligh & Ceramah')) {
        unique.add('Tabligh & Ceramah');
      }
    }
    return unique.isEmpty ? ['Umum'] : unique;
  }
}
