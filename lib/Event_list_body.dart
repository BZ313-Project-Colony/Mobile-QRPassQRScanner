import 'package:flutter/material.dart';
import 'package:login_screen/Models/events_model.dart';
import 'package:login_screen/Services/token_jobs.dart';

class EtkinlikApi extends StatefulWidget {
  const EtkinlikApi({super.key});

  @override
  State<EtkinlikApi> createState() => _EtkinlikApiState();
}

class _EtkinlikApiState extends State<EtkinlikApi> {
  TokenEventListJobs tokenEventJob = TokenEventListJobs();

  @override
  Widget build(BuildContext context) {
    tokenEventJob.getEventList();
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Etkinlikler", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: FutureBuilder<List<EtkinlikModel>>(
            future: tokenEventJob.getEventList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var etknlkList = snapshot.data!;
                return ListView.builder(
                  reverse: false,
                  itemBuilder: (BuildContext context, int index) {
                    var Etk = etknlkList[index];
                    return Card(
                      margin: EdgeInsets.all(7),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text(Etk.time.toString())]),
                        title: Text(Etk.title),
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          child: Text((index + 1).toString()),
                        ),
                      ),
                    );
                  },
                  itemCount: etknlkList.length,
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else
                return CircularProgressIndicator();
              //return Text("Bekleyiniz");
            },
          ),
        ));
  }
}
