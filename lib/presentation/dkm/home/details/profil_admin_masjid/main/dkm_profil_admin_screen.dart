import 'package:flutter/material.dart';
import 'package:masjidku/component/main/button/main_button.dart'; // ⬅️ pastikan ini di-import

class DkmProfilAdminScreen extends StatefulWidget {
  const DkmProfilAdminScreen({super.key});

  @override
  State<DkmProfilAdminScreen> createState() => _DkmProfilAdminScreenState();
}

class _DkmProfilAdminScreenState extends State<DkmProfilAdminScreen> {
  final TextEditingController _nameController = TextEditingController(
    text: 'Budi Hadi',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'budi@gmail.com',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: '********',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Admin Masjid"),
        leading: const BackButton(),
        actions: const [Icon(Icons.more_vert), SizedBox(width: 12)],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Harap diisi profil admin untuk kemajuan aplikasi. Data pengguna insya Allah akan kami lindungi.",
            ),
            const SizedBox(height: 20),
            _buildInputField("Nama", _nameController),
            const SizedBox(height: 20),
            _buildInputField("Email", _emailController),
            const SizedBox(height: 20),
            _buildInputField("Password", _passwordController, isPassword: true),
            const Spacer(),
            MainButton(
              label: "Kirim",
              onPressed: () {
                // TODO: Submit profil
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller, {
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: const Icon(Icons.edit, size: 18),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
    );
  }
}