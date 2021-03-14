import 'package:flutter/material.dart';
import 'package:using_listview/api_requests/feeder.dart';
import 'package:using_listview/feederlist/feeder_list_item.dart';
import 'package:using_listview/feederlist/modal/feeder.dart';

class FeederList extends StatelessWidget {
  FeederList();

  @override
  Widget build(BuildContext ctxt) {
    return Container(
      child: FutureBuilder(
        future: fetchFeeders(),
        // ignore: missing_return
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text("there is no connection");

            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(child: new CircularProgressIndicator());

            case ConnectionState.done:
              if (snapshot.data != null) {
                List<FeederModel> feeders =
                    new List(snapshot.data.length);
                for (var i = 0; i < snapshot.data.length; i++) {
                  feeders[i] = FeederModel.fromJson(snapshot.data[i]);
                }

                return ListView.builder(
                    itemExtent: 90,
                    itemCount: feeders
                        .length, // getting map length you can use keyList.length too
                    itemBuilder: (BuildContext context, int index) {
                      return FeederListItem(feeders[index]);
                    });
              }
              // here your snapshot data is null so SharedPreferences has no data...
              return Text("No data was loaded!");
          } //end switch
        },
      ),
    );
  }
}
