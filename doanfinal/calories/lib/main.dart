import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:calories/components/donut_chart.dart';
import 'package:calories/components/small_donut_chart.dart';

void main() => runApp(MyApp());
GlobalKey<SmallDonutChartState> globalKey = GlobalKey();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'doan demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            brightness: Brightness.light,
            color: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          textTheme: TextTheme(
              title: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "OpenSans",
          ))),
      home: MyHomePage(title: 'noi dung'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  int _counter = 0;
  SystemUiOverlayStyle systemUiOverlayStyle = new SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.black54,
  );
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    reset();
  }

  void reset() {
    setState(() {
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        reset();
        break;
      case AppLifecycleState.inactive:
        // TODO: Handle this case.
        break;
      case AppLifecycleState.paused:
        // TODO: Handle this case.
        break;
      case AppLifecycleState.suspending:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      globalKey.currentState.playAnimation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: false,
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 15.0, bottom: 5),
              title: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () => {},
                child: Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.keyboard_arrow_left),
                onPressed: () => _incrementCounter(),
              ),
              IconButton(
                icon: Icon(Icons.keyboard_arrow_right),
                onPressed: () => _incrementCounter(),
              )
            ],
          ),
          SliverToBoxAdapter(
              child: Column(
            children: <Widget>[
              Container(
                height: 300,
                padding: EdgeInsets.all(20),
                child: DonutChart(),
              ),
              Container(
                height: 300,
                width: 300,
                padding: EdgeInsets.all(80),
                child: SmallDonutChart(
                  key: globalKey,
                ),
              ),
              Card(
                elevation: 0,
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10),
                  side: BorderSide(color: Colors.grey[400]),
                ),
                margin: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      contentPadding:
                          EdgeInsets.only(left: 20, top: 20, right: 20),
                      title: Text('A calorie is a unit of energy'),
                      subtitle: Text(
                          '\ntext................................................................................'),
                    ),
                    ButtonTheme.bar(
                      // make buttons use the appropriate styles for cards
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: const Text('Bỏ qua'),
                            onPressed: () {/* ... */},
                          ),
                          FlatButton(
                            child: const Text('Tìm hiểu thêm'),
                            onPressed: () {/* ... */},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 80,
              ),
            ],
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        icon: Icon(Icons.add),
        label: Text("nut bam"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.data_usage),
            title: Text("nhat ki"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_dining),
            title: Text("thuc an"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subject),
            title: Text("thuc don"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            title: Text("Ho so"),
          ),
        ],
      ),
    );
  }
}
