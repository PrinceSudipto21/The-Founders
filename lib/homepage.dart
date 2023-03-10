import 'package:flutter/material.dart';

import 'navBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _MyHomePage();
}

class _MyHomePage extends State<HomePage> {
  bool Relevance = false;
  bool Time = false;
  bool Local = false;
  bool Central = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("The Founders"),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                  height: 30,
                  child: InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NavBar()),
                      );
                    },
                    child: Image.asset(
                      'assets/images/icon.png',
                      height: 35,
                    ),
                  )),
              Container(
                  height: 20,
                  child: Image.asset(
                    'assets/images/search.jpg',
                    height: 35,
                  )),
              Container(
                width: 180,
                height: 30,
                child: TextField(
                    decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.yellowAccent.shade700)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black)),
                  labelText: 'Search your needs',
                )),
              ),
              Container(
                  height: 30,
                  child:
                      ElevatedButton(onPressed: () {}, child: Text("Filter"))),
            ]),
            Container(
              height: 30,
            ),
            Row(children: [
              Column(
                children: [
                  Text("Sort your results",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      )),

                  Text("Advertisements: ",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              Container(
                width: 15,
              ),
              Row(children: [
                Text(
                  "SCHEMES AVAILABLE: ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                /*ListView.builder(
                  itemBuilder: (context, index) {
                    return Text("Ho");
                  },
                  itemCount: 5,
                ),*/
              ])
            ]),
          ]),
        ));
  }
}
