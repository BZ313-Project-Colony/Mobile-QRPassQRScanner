import 'package:flutter/material.dart';
import 'package:login_screen/Models/events_model.dart';
import 'package:login_screen/Services/token_jobs.dart';

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
                var etknlkList = snapshot.data!;
                return ListView.builder(
                  reverse: true,
                  itemBuilder: (BuildContext context, int index) {
                    var event = etknlkList[index];
                    return Card(
                      margin: const EdgeInsets.all(7),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text(event.time.toString())]),
                        title: Text(event.title),
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Text(etknlkList[index].toString()),
                        ),
                      ),
                    );
                  },
                  itemCount: etknlkList.length,
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const CircularProgressIndicator();
              }
              //return Text("Bekleyiniz");
            },
          ),
        ));
  }
}
