import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'kajian_card.dart';

class CalendarKajianView extends StatefulWidget {
  final List<Map<String, dynamic>> historyList;

  const CalendarKajianView({super.key, required this.historyList});

  @override
  State<CalendarKajianView> createState() => _CalendarKajianViewState();
}

class _CalendarKajianViewState extends State<CalendarKajianView> {
  DateTime selectedDay = DateTime.now();

  @override

  Widget build(BuildContext context) {
    final selectedEvents =
        widget.historyList
            .where((event) => isSameDay(event['date'], selectedDay))
            .toList();

    return Column(
      children: [
        TableCalendar(
          focusedDay: selectedDay,
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          calendarFormat: CalendarFormat.month,
          selectedDayPredicate: (day) => isSameDay(selectedDay, day),
          onDaySelected: (selected, _) {
            setState(() => selectedDay = selected);
          },
          eventLoader: (day) {
            return widget.historyList
                .where((event) => isSameDay(event['date'], day))
                .toList();
          },
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          calendarStyle: const CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.teal,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
            markerDecoration: BoxDecoration(
              color: Colors.redAccent,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child:
              selectedEvents.isEmpty
                  ? const Center(
                    child: Text(
                      "Tidak ada kajian di hari ini.",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                  : ListView.builder(
                    itemCount: selectedEvents.length,
                    itemBuilder: (context, index) {
                      return KajianCard(item: selectedEvents[index]);
                    },
                  ),
        ),
      ],
    );
  }
}
