import 'package:flutter/material.dart';
import 'package:login_screen/Models/events_model.dart';
import 'package:login_screen/Services/token_jobs.dart';
import 'package:login_screen/date_utils.dart';
import 'events_detail_screen.dart';

class EventApi extends StatefulWidget {
  const EventApi({super.key});

  @override
  State<EventApi> createState() => _EventApiState();
}

class _EventApiState extends State<EventApi> {
  TokenEventListJobs tokenEventJob = TokenEventListJobs();

  @override
  Widget build(BuildContext context) {
    tokenEventJob.getEventList();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Etkinlikler", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: FutureBuilder<List<EtkinlikModel>>(
          future: tokenEventJob.getEventList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var eventList = snapshot.data!;
              return ListView.builder(
                reverse: false,
                itemBuilder: (BuildContext context, int index) {
                  var event = eventList[index];
                  return Card(
                    margin: const EdgeInsets.all(7),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      onTap: () {
                        // Navigate to EventDetailsPage when the item is clicked
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventDetailsPage(event: event),
                          ),
                        );
                      },
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateUtilsFunctions.addHoursAndFormat(
                                event.time.toString()),
                          ),
                        ],
                      ),
                      title: Text(event.title),
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        child: Text((index + 1).toString()),
                      ),
                    ),
                  );
                },
                itemCount: eventList.length,
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

