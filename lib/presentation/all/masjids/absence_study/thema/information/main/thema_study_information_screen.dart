import 'package:flutter/material.dart';
import 'package:masjidku/presentation/all/masjids/absence_study/widgets/info_item_component.dart';

class DetailThemaStudyInformationScreen extends StatefulWidget {
  const DetailThemaStudyInformationScreen({super.key});

  @override
  State<DetailThemaStudyInformationScreen> createState() =>
      _DetailThemaStudyInformationScreenState();
}

class _DetailThemaStudyInformationScreenState
    extends State<DetailThemaStudyInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informasi"),
        leading: const BackButton(),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.more_vert),
          SizedBox(width: 8),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
        child: InfoSection(),
      ),
    );
  }
}
