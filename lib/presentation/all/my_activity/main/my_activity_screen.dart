import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjidku/core/utils/auth_cubit.dart';
import 'package:masjidku/presentation/all/home/main/cubit/navigation_cubit.dart';
import 'package:masjidku/presentation/all/my_activity/main/widget/upcoming_kajian.dart';
import 'package:masjidku/presentation/all/my_activity/main/widget/user_info_section.dart';
import 'package:masjidku/presentation/all/my_activity/main/widget/user_profile_section.dart';

class MyActivityScreen extends StatefulWidget {
  const MyActivityScreen({super.key});

  @override
  State<MyActivityScreen> createState() => _MyActivityScreenState();
}

class _MyActivityScreenState extends State<MyActivityScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NavigationCubit>().changeTab(4);
    context.read<AuthCubit>().checkLoginStatus(); // ⬅️ Pindah ke sini
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Aktivitas Saya"), elevation: 0),
      body: LayoutBuilder(
        builder:
            (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      UserProfileSection(),
                      SizedBox(height: 12),
                      UserInfoSection(),
                      SizedBox(height: 12),
                      UpcomingKajianSection(), // ⬅️ ini akan rebuild saat state AuthCubit berubah
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
