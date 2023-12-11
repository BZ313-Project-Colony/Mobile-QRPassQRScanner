import 'package:flutter/material.dart';
import 'package:login_screen/Models/events_model.dart';

import '../date_utils.dart';

class EventDetailsPage extends StatelessWidget {
  final EtkinlikModel event;

  const EventDetailsPage({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Etkinlik Adı: ${event.title}'),
            Text(
              'Tarih ve Saat: '
                  '${DateUtilsFunctions.addHoursAndFormat(event.time.toString())}',
            ),
            // Add other details as needed
          ],
        ),
      ),
    );
  }
}
