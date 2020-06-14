import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MainLayout extends StatefulWidget {
  @override
  MainLayoutState createState() => MainLayoutState();
}

class MainLayoutState extends State<MainLayout> {
  List _buildCards() {
    List<Widget> cards = List();

    for (int i = 0; i < 10; i++) {
      cards.add(Card(
        margin: EdgeInsets.all(10.0),
        elevation: 2.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Wowee there's only",
                style: TextStyle(
                  fontSize: 40,
                  color: Theme.of(context).primaryColor,
                )),
            CountDownInfo(),
            Text("minutes until CMIMC",
                style: TextStyle(
                  fontSize: 40,
                  color: Theme.of(context).primaryColor,
                )),
            const ListTile(
              leading: Icon(Icons.album),
              title: Text('The Enchanted Nightingale'),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('BUY TICKETS'),
                  onPressed: () {/* ... */},
                ),
                FlatButton(
                  child: const Text('LISTEN'),
                  onPressed: () {/* ... */},
                ),
              ],
            ),
          ],
        ),
      ));
    }

    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 100.0,
            floating: true,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text("CMIMC Day Of"),
              //background:
              //Image(image: AssetImage('images/cmimc-logo-huge.png')),
            ),
          ),
          new SliverList(delegate: new SliverChildListDelegate(_buildCards())),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: null,
              accountName: Text("Bassim Bomais"),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  //backgroundImage: null,
                  child: Text('BB'),
                ),
                onTap: () => {},
              ),
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: new NetworkImage(
                          "https://img00.deviantart.net/35f0/i/2015/018/2/6/low_poly_landscape__the_river_cut_by_bv_designs-d8eib00.jpg"),
                      fit: BoxFit.fill)),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'CMIMC Day Of', home: MainLayout());
  }
}

class CountDownInfo extends StatefulWidget {
  @override
  CountDownInfoState createState() => CountDownInfoState();
}

class CountDownInfoState extends State<CountDownInfo>
    with TickerProviderStateMixin {
  AnimationController _controller;
  int levelClock = 421*60;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Countdown(
        animation: StepTween(
          begin: levelClock,
          end: 0,
        ).animate(_controller),
      ),
    ]);
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key key, this.animation}) : super(key: key, listenable: animation);

  final Animation<int> animation;

  @override
  build(context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    /*
    print('animation.value  ${animation.value} ');
    print('inMinutes ${clockTimer.inMinutes.toString()}');
    print('inSeconds ${clockTimer.inSeconds.toString()}');
    print('inSeconds.remainder ${clockTimer.inSeconds.remainder(60).toString()}');
	*/

    return Text(
      "$timerText",
      style: TextStyle(
        fontSize: 110,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
