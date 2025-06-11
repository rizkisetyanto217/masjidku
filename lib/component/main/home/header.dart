import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class HeaderSection extends StatefulWidget {
  final Widget quote;

  const HeaderSection({super.key, required this.quote});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  final storage = const FlutterSecureStorage();
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final token = await storage.read(key: 'access_token');
    setState(() {
      isLoggedIn = token != null;
    });
  }

  Future<void> logout(BuildContext context) async {
    await storage.deleteAll();
    setState(() => isLoggedIn = false);
    if (context.mounted) context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TopBar(isLoggedIn: isLoggedIn, onLogout: () => logout(context)),
          const SizedBox(height: 16),
          widget.quote,
          const SizedBox(height: 16),
          const _SearchBar(),
          const SizedBox(height: 16),
          const _CollaborationInfo(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final bool isLoggedIn;
  final VoidCallback onLogout;

  const _TopBar({required this.isLoggedIn, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset("assets/images/masjidku-logo.png", height: 28),
        InkWell(
          onTap: () {
            if (isLoggedIn) {
              onLogout();
            } else {
              context.push('/login');
            }
          },
          child: Text(
            isLoggedIn ? "Logout" : "Login",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        context.push('/search');
      },
      child: AbsorbPointer(
        child: TextField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: 'Cari Masjid',
            hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.5)),
            prefixIcon: Icon(Icons.search, color: colorScheme.onSurface),
            filled: true,
            fillColor: colorScheme.surface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}

class _CollaborationInfo extends StatelessWidget {
  const _CollaborationInfo();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      "Alhamdulillah, telah bekerjasama dengan 10+ Masjid dan Lembaga",
      style: TextStyle(color: colorScheme.onPrimary, fontSize: 12),
    );
  }
}
