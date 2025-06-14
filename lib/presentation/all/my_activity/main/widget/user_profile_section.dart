import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/button/small_button.dart';
import 'package:masjidku/core/constants/app_color.dart';
import 'package:masjidku/core/utils/auth_cubit.dart';
import 'package:masjidku/presentation/all/my_activity/main/cubit/user_profile_section_cubit.dart';
import 'package:masjidku/presentation/all/my_activity/main/cubit/user_profile_section_state.dart';

class UserProfileSection extends StatefulWidget {
  
  const UserProfileSection({super.key});

  @override
  State<UserProfileSection> createState() => _UserProfileSectionState();
}

class _UserProfileSectionState extends State<UserProfileSection> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final authState = context.read<AuthCubit>().state;
    final cubit = context.read<UserProfileCubit>();
    final token = authState.token;

    if (authState.isLoggedIn && token != null) {
      if (cubit.state is! UserProfileLoaded ||
          (cubit.state is UserProfileLoaded &&
              (cubit.state as UserProfileLoaded).token != token)) {
        cubit.fetchUserProfile(token);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        if (authState.isChecking) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!authState.isLoggedIn || authState.token == null) {
          return _buildNotLoggedInSection(colorScheme, context);
        }

        return BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, profileState) {
            if (profileState is UserProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (profileState is UserProfileError) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Gagal memuat data user: ${profileState.message}',
                  style: TextStyle(color: colorScheme.error),
                ),
              );
            }

            if (profileState is UserProfileLoaded) {
              final user = profileState.user;
              return _buildProfile(user, context);
            }

            return const SizedBox.shrink();
          },
        );
      },
    );
  }

  Widget _buildNotLoggedInSection(
    ColorScheme colorScheme,
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Belum Login",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.white1,
            ),
          ),
          const SizedBox(height: 12),
          SmallButton(
            text: "Pengaturan",
            onPressed: () => context.push('/my-activity/more'),
            backgroundColor: Colors.white,
            textColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildProfile(Map<String, dynamic> user, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00796B), Color(0xFF004D40)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 32, color: AppColors.primary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['user_name'] ?? 'User',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user['email'] ?? '',
                      style: const TextStyle(color: AppColors.tertiary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: SmallButton(
                  text: "12 Masjid Saya",
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  textColor: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SmallButton(
                  text: "Pengaturan",
                  onPressed: () => context.push('/my-activity/more'),
                  backgroundColor: AppColors.secondary,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
