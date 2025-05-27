import 'package:flutter/material.dart';
import 'package:masjidku/component/main/button/main_button.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final TextEditingController nameController = TextEditingController(
    text: "Budi Hadi",
  );
  final TextEditingController donorNameController = TextEditingController(
    text: "Abu Harist",
  );
  final TextEditingController passwordController = TextEditingController(
    text: "12345678",
  );
  final TextEditingController emailController = TextEditingController(
    text: "budi@gmail.com",
  );
  final TextEditingController phoneController = TextEditingController(
    text: "0851-5423-7891",
  );
  final TextEditingController domicileController = TextEditingController(
    text: "Duren Sawit, Jakarta Timur",
  );
  final TextEditingController birthDateController = TextEditingController(
    text: "3 Januari 2020",
  );
  final TextEditingController genderController = TextEditingController(
    text: "Laki-laki",
  );
  final TextEditingController jobController = TextEditingController(
    text: "Karyawan swasta",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        title: const Text("Profil"),
        leading: const BackButton(),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Harap diisi profil pengguna untuk kemajuan aplikasi. Data pengguna insya Allah akan kami lindungi.",
              style: TextStyle(color: Colors.black87),
            ),
            const SizedBox(height: 16),
            _buildEditableField(
              label: "Nama",
              controller: nameController,
              helper: "Nama lengkap akan tercantum untuk umum sertifikat.",
            ),
            _buildEditableField(
              label: "Nama Donatur",
              controller: donorNameController,
              helper:
                  "Nama donatur akan terlihat oleh pengguna lain pada papan donasi.",
            ),
            _buildEditableField(
              label: "Password",
              controller: passwordController,
              obscure: true,
            ),
            _buildEditableField(label: "Email", controller: emailController),
            _buildEditableField(
              label: "Nomor Telp",
              controller: phoneController,
            ),
            _buildEditableField(
              label: "Domisili",
              controller: domicileController,
              hint: "Kecamatan, Kota/Kabupaten",
            ),
            _buildEditableField(
              label: "Tanggal Lahir",
              controller: birthDateController,
              isDate: true,
            ),
            _buildEditableField(
              label: "Jenis Kelamin",
              controller: genderController,
              isDropdown: true,
              dropdownItems: ["Laki-laki", "Perempuan"],
            ),
            _buildEditableField(label: "Pekerjaan", controller: jobController),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: MainButton(
          label: "Simpan Perubahan",
          onPressed: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Profil disimpan!")));
          },
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    bool obscure = false,
    String? helper,
    String? hint,
    bool isDropdown = false,
    bool isDate = false,
    List<String>? dropdownItems,
  }) {
    final decoration = InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF8F8F8),
      suffixIcon:
          isDate
              ? const Icon(
                Icons.calendar_today_outlined,
                size: 18,
                color: Colors.grey,
              )
              : const Icon(Icons.edit_outlined, size: 18, color: Colors.grey),
      helperText: helper,
      helperStyle: const TextStyle(fontSize: 12, color: Colors.green),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    );

    Widget field;

    if (isDropdown) {
      field = DropdownButtonFormField<String>(
        value: controller.text.isNotEmpty ? controller.text : null,
        onChanged: (value) {
          if (value != null) {
            setState(() => controller.text = value);
          }
        },
        icon: const Icon(Icons.arrow_drop_down),
        decoration: decoration,
        dropdownColor: Colors.white,
        style: const TextStyle(fontSize: 14, color: Colors.black87),
        items:
            dropdownItems
                ?.map(
                  (item) => DropdownMenuItem(value: item, child: Text(item)),
                )
                .toList(),
      );
    } else if (isDate) {
      field = GestureDetector(
        onTap: () async {
          final pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now().subtract(
              const Duration(days: 365 * 20),
            ),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            helpText: 'Pilih Tanggal Lahir',
          );

          if (pickedDate != null) {
            final formatted =
                "${pickedDate.day} ${_monthName(pickedDate.month)} ${pickedDate.year}";
            setState(() => controller.text = formatted);
          }
        },
        child: AbsorbPointer(
          child: TextField(controller: controller, decoration: decoration),
        ),
      );
    } else {
      field = TextField(
        controller: controller,
        obscureText: obscure,
        decoration: decoration,
      );
    }

    return Padding(padding: const EdgeInsets.only(bottom: 16), child: field);
  }

  String _monthName(int month) {
    final months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return months[month - 1];
  }
}
