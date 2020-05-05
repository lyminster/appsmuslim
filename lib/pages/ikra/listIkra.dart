import 'package:flutter/material.dart';

class ListIkra extends StatefulWidget {
  @override
  _ListIkraState createState() => _ListIkraState();
}

class _ListIkraState extends State<ListIkra>
    with SingleTickerProviderStateMixin {
  @override
  TabController controller;

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 10);
    super.initState();
  }

  final List<Tab> myTabs = List.generate(
    10,
    (index) => Tab(text: 'TAB $index'),
  );
  
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Baca Iqra"),
        bottom: TabBar(
          isScrollable: true,
          controller: controller,
          tabs: myTabs,
        ),
      ),
      backgroundColor: Color(0xffFFF8E2),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 27.0, 0.0, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xffE9CB97),
                    ),
                    height: 107,
                    width: 112,
                    child: Center(
                      child: Text(
                        'IQRA 2',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 27.0, 0.0, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xffE9CB97),
                    ),
                    height: 107,
                    width: 112,
                    child: Center(
                      child: Text(
                        'IQRA 1',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30.0, 40.0, 0.0, 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xffE9CB97),
                        ),
                        height: 107,
                        width: 112,
                        child: Center(
                          child: Text(
                            'IQRA 3',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30.0, 40.0, 0.0, 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xffE9CB97),
                        ),
                        height: 107,
                        width: 112,
                        child: Center(
                          child: Text(
                            'IQRA 4',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 40.0, 0.0, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xffE9CB97),
                    ),
                    height: 107,
                    width: 112,
                    child: Center(
                      child: Text(
                        'IQRA 5',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 40.0, 0.0, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xffE9CB97),
                    ),
                    height: 107,
                    width: 112,
                    child: Center(
                      child: Text(
                        'IQRA 6',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
