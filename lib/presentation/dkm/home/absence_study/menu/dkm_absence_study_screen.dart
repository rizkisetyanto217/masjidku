import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masjidku/component/main/home/calender/calender_kajian_view.dart';
import 'package:masjidku/component/main/home/calender/kajian_tema_card.dart';
import 'package:masjidku/component/main/home/tab_switch_component.dart';

class DkmAbsenceStudyScreen extends StatefulWidget {
  const DkmAbsenceStudyScreen({super.key});

  @override
  State<DkmAbsenceStudyScreen> createState() => _DkmAbsenceStudyScreenState();
}

class _DkmAbsenceStudyScreenState extends State<DkmAbsenceStudyScreen> {
  final List<Map<String, dynamic>> kajianList = [
    {
      "judul": "Rencana Allah yang terbaik",
      "ustadz": "Ustadz Abdullah",
      "tanggal": "4 Maret 2025, Pukul 10.00 WIB",
      "status": "Tersedia pukul 20.00 WIB",
      "statusColor": Colors.orange,
    },
    {
      "judul": "Rencana Allah yang terbaik (2)",
      "ustadz": "Ustadz Abdullah",
      "tanggal": "4 Maret 2025, Pukul 10.00 WIB",
      "status": "Soal dan Materi sudah tersedia",
      "statusColor": Colors.green,
    },
  ];

  final List<String> tabs = ["Terbaru", "Tema", "Bulan"];
  String selectedTab = "Terbaru";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Halaman Kajian"),
        leading: const BackButton(),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.more_vert),
          SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabSwitch(
              tabs: tabs,
              selectedTab: selectedTab,
              onChanged: (val) => setState(() => selectedTab = val),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                DropdownButton<String>(
                  value: selectedTab,
                  items:
                      tabs
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => selectedTab = val);
                  },
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.view_agenda_outlined),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_today_outlined),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (selectedTab == "Terbaru") {
                    return ListView.separated(
                      itemCount: kajianList.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final kajian = kajianList[index];
                        return ListTile(
                          onTap: () {
                            context.go('/dkm/study/study');
                          },
                          title: Text(
                            kajian['judul'],
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(kajian['ustadz']),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time_filled,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    kajian['tanggal'],
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                kajian['status'],
                                style: TextStyle(
                                  fontSize: 13,
                                  color: kajian['statusColor'],
                                ),
                              ),
                            ],
                          ),
                          isThreeLine: true,
                        );
                      },
                    );
                  } else if (selectedTab == "Tema") {
                    return ListView(
                      children: [
                        KajianTemaCard(
                          judul: "Kajian Fiqh",
                          jumlahKajian: 12,
                          status: "Kajian sedang berjalan",
                          statusColor: Colors.orange,
                          onTap: () {
                            context.go('/dkm/study/thema');
                          },
                        ),
                        KajianTemaCard(
                          judul: "Kajian Aqidah",
                          jumlahKajian: 20,
                          status: "Kajian telah selesai",
                          statusColor: Colors.teal,
                          onTap: () {
                            context.go('/dkm/study/thema');
                          },
                        ),
                      ],
                    );
                  } else {
                    // 👉 Bagian Bulan: tampilkan dalam bentuk kalender
                    // mapping data agar ada field `date` nya
                    final calendarData =
                        kajianList.map((item) {
                          final parts = item['tanggal'].split(', Pukul');
                          final tanggalStr = parts[0].trim();
                          final waktuStr = 'Pukul${parts[1]}'.trim();

                          DateTime? parsedDate;
                          try {
                            parsedDate = DateTime.parse(
                              "2025-${_convertBulanToAngka(tanggalStr.split(' ')[2])}-${tanggalStr.split(' ')[1]}",
                            );
                          } catch (_) {
                            parsedDate = DateTime.now(); // fallback
                          }

                          return {
                            ...item,
                            'date': parsedDate,
                            'waktu': waktuStr,
                            'badges': [
                              {
                                "label": item['status'],
                                "color": item['statusColor'],
                              },
                            ],
                          };
                        }).toList();

                    return CalendarKajianView(historyList: calendarData);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _convertBulanToAngka(String namaBulan) {
  const Map<String, String> bulanMap = {
    "Januari": "01",
    "Februari": "02",
    "Maret": "03",
    "April": "04",
    "Mei": "05",
    "Juni": "06",
    "Juli": "07",
    "Agustus": "08",
    "September": "09",
    "Oktober": "10",
    "November": "11",
    "Desember": "12",
  };

  return bulanMap[namaBulan] ?? "01";
}
