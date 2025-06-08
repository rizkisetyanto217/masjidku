import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjidku/component/main/information/information_filter_tabs.dart';
import 'package:masjidku/component/main/information/information_post_list.dart';
import 'package:masjidku/core/constants/app_spacing.dart';
import 'package:masjidku/presentation/all/masjids/details/information/cubit/notification_cubit.dart';
import 'package:masjidku/presentation/all/masjids/details/information/cubit/notification_state.dart';
import 'package:masjidku/presentation/all/masjids/model/masjid_detail_profile.dart';

class InformationMasjidScreeen extends StatefulWidget {
  final MasjidDetailModel masjid;
  const InformationMasjidScreeen({super.key, required this.masjid});

  @override
  State<InformationMasjidScreeen> createState() =>
      _InformationMasjidScreeenState();
}

class _InformationMasjidScreeenState extends State<InformationMasjidScreeen> {
  int selectedFilterIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informasi"),
        leading: const BackButton(),
        actions: const [
          Icon(Icons.search),
          AppSpacing.lg,
          Icon(Icons.more_vert),
          AppSpacing.sm,
        ],
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotificationError) {
            return Center(child: Text("Data belum ada: ${state.message}"));
          } else if (state is NotificationLoaded) {
            final posts = List<Map<String, dynamic>>.from(state.notifications);
            return _buildBody(posts);
          }
          return const SizedBox(); // Initial state
        },
      ),
    );
  }

  Widget _buildBody(List<Map<String, dynamic>> posts) {
    // ✅ Extract kategori
    final categories =
        posts
            .map((e) => (e['notification_category'] ?? 'Umum').toString())
            .toSet() 
            .toList();

    // ✅ Jika tidak ada kategori
    if (categories.isEmpty) {
      return const Center(child: Text("Belum ada informasi tersedia."));
    }

    final selectedCategory = categories[selectedFilterIndex];

    final filteredPosts =
        posts.where((e) {
          final category = (e['notification_category'] ?? 'Umum').toString();
          return category == selectedCategory;
        }).toList();

    // ✅ Debug log
    debugPrint("📂 Kategori tersedia: $categories");
    debugPrint("📑 Kategori terpilih: $selectedCategory");
    debugPrint("📋 Jumlah informasi: ${filteredPosts.length}");

    if (filteredPosts.isEmpty) {
      return Column(
        children: [
          AppSpacing.md,
          InformationFilterTabs(
            categories: categories,
            selectedIndex: selectedFilterIndex,
            onSelected: (i) => setState(() => selectedFilterIndex = i),
          ),
          const Expanded(child: Center(child: Text("Belum ada informasi."))),
        ],
      );
    }

    final displayData =
        filteredPosts.map((e) {
          return {
            'category': (e['notification_category'] ?? 'Umum').toString(),
            'time': (e['notification_created_at'] ?? 'Baru saja').toString(),
            'title': (e['notification_title'] ?? '-').toString(),
            'content': (e['notification_description'] ?? '').toString(),
          };
        }).toList();

    return Column(
      children: [
        AppSpacing.md,
        InformationFilterTabs(
          categories: categories,
          selectedIndex: selectedFilterIndex,
          onSelected: (i) => setState(() => selectedFilterIndex = i),
        ),
        InformationPostList(data: displayData),
      ],
    );
  }
}
