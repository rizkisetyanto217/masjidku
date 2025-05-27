import 'package:flutter/material.dart';
import 'package:masjidku/presentation/all/home/home/information/detail/information_detail_screen.dart';

class InformationPostList extends StatelessWidget {
  final List<Map<String, String>> data;

  const InformationPostList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Expanded(child: Center(child: Text("Belum ada informasi.")));
    }

    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 8, bottom: 12),
        itemCount: data.length,
        separatorBuilder: (_, __) => const Divider(indent: 16, endIndent: 16),
        itemBuilder: (context, index) {
          final post = data[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => InformasiDetailPage(
                        category: post['category']!,
                        time: post['time']!,
                        title: post['title']!,
                        content: post['content'] ?? post['title']!,
                      ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post['category']!,
                    style: const TextStyle(
                      color: Color(0xFF006B64),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    post['time']!,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    post['title']!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
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
