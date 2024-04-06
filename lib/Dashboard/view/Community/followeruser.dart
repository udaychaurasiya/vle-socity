import 'package:flutter/material.dart';
class Followers extends StatefulWidget {
  const Followers({Key? key}) : super(key: key);

  @override
  State<Followers> createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("huyg"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: 1000,
              itemBuilder: (BuildContext context, int index) {
                if (index % 7 == 1) {
                  return Column(
                    children: <Widget>[
                      Container(
                        height: 50.0, // Adjust the height as needed
                        color: Colors.blue, // Optional: Add color to the container
                        // Other container properties
                      ),
                      ListTile(
                        title: Text('Item $index'),
                        // Other ListTile properties
                      ),
                    ],
                  );
                } else {
                  return ListTile(
                    title: Text('Item $index'),
                    // Other ListTile properties
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
