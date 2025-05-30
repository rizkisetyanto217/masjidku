import 'package:flutter/material.dart';

class MasjidProfilScreen extends StatelessWidget {
  const MasjidProfilScreen({super.key});

  final Map<String, dynamic> masjidProfileData = const {
    "title": "Profil Lembaga",
    "content": '''
Masjid At-Taqwa didirikan pada tahun 2000 dengan tujuan untuk menjadi tempat ibadah untuk warga Ciracas dan sekitarnya.

Dari Umar bin Khattab radhiyallahu 'anhu, ia berkata: Suatu hari kami duduk bersama Rasulullah ﷺ, lalu datang seorang laki-laki berpakaian sangat putih dan berambut sangat hitam (Jibril). Ia bertanya: "Wahai Muhammad, kabarkan kepadaku tentang iman." Rasulullah ﷺ menjawab:

"Iman adalah engkau beriman kepada Allah, malaikat-malaikat-Nya, kitab-kitab-Nya, rasul-rasul-Nya, hari akhir, dan engkau beriman kepada takdir yang baik maupun yang buruk." 

Hadis ini secara eksplisit menyebutkan urutan rukun iman yang menjadi dasar keyakinan umat Islam.
''',
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(masjidProfileData['title']),
        leading: const BackButton(),
        actions: const [Icon(Icons.more_vert), SizedBox(width: 8)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(
            masjidProfileData['content'],
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}