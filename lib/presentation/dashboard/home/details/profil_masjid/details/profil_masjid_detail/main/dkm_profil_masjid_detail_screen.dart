import 'package:flutter/material.dart';
import 'package:masjidku/component/main/button/main_button.dart';

class DkmProfilMasjidDetailScreen extends StatefulWidget {
  const DkmProfilMasjidDetailScreen({super.key});

  @override
  State<DkmProfilMasjidDetailScreen> createState() =>
      _DkmProfilMasjidDetailScreenState();
}

class _DkmProfilMasjidDetailScreenState
    extends State<DkmProfilMasjidDetailScreen> {
  final _namaController = TextEditingController(text: 'Masjid At–Taqwa');
  final _tentangController = TextEditingController(
    text: 'Dikelola oleh DKM Masjid',
  );
  final _alamatController = TextEditingController(
    text: 'Jln. Penganten Ali Gang Mandiri Jakarta Timur',
  );
  final _profilLengkapController = TextEditingController(
    text:
        'Masjid ini dibangun pada tahun 2020 dengan tujuan agar mempermudah muslimin dalam beribadah dan menuntut ilmu dengan tanah wakaf dari Bapak Tono dan keluarga.',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Masjid"),
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
            _buildInputField("Nama Masjid", _namaController),
            const SizedBox(height: 20),
            _buildInputField(
              "Tentang Masjid ( Maksimal 30 kata )",
              _tentangController,
            ),
            const SizedBox(height: 20),
            _buildInputField("Alamat Masjid", _alamatController),
            const SizedBox(height: 20),
            _buildInputField(
              "Profil Lengkap Masjid",
              _profilLengkapController,
              maxLines: 4,
            ),
            const Spacer(),
            MainButton(
              label: "Kirim",
              onPressed: () {
                // TODO: Submit logic
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
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
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
