import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/home/button_nav.dart';
import 'package:masjidku/presentation/all/home/home/main/cubit/navigation_cubit.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex) {
          return BottomNavbar(
            currentIndex: currentIndex,
            onTap: (index) {
              if (index == currentIndex) return;
              context.read<NavigationCubit>().changeTab(index);
              switch (index) {
                case 0:
                  context.go('/home');
                  break;
                case 1:
                  context.go('/time-pray');
                  break;
                case 2:
                  context.go('/posting');
                  break;
                case 3:
                  context.go('/donasi');
                  break;
                case 4:
                  context.go('/my-activity');
                  break;
              }
            },
          );
        },
      ),
    );
  }
}
