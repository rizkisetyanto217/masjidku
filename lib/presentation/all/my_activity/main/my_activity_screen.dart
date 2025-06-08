import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/button/main_button.dart';
import 'package:masjidku/component/main/button/small_button.dart';
import 'package:masjidku/core/constants/app_color.dart';
import 'package:masjidku/presentation/all/home/main/cubit/navigation_cubit.dart';
import 'package:masjidku/presentation/all/my_activity/main/widget/upcoming_kajian.dart';
import 'package:masjidku/presentation/all/my_activity/main/widget/user_info_section.dart';
import 'package:masjidku/presentation/all/my_activity/main/widget/user_profile_section.dart';

class MyActivityScreen extends StatelessWidget {
  const MyActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NavigationCubit>().changeTab(4);

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
                    children: [
                      // const SizedBox(height: 16),
                      UserProfileSection(),
                      const SizedBox(height: 12),
                      UserInfoSection(),
                      const SizedBox(height: 12),
                      UpcomingKajianSection(),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}

