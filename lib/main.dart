import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Animations'),
        centerTitle: true,
      ),
      body: Center(
        child: FlatButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return SecondPage();
            }
          )),
          child: Text('Tap to see the kitty'),
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController= AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150)
    );
    Timer(Duration(milliseconds: 200), () => _animationController.forward());

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kitty Page'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          TextAndImage(
            animationController: _animationController,
          ),
          Bottom(
            animationController: _animationController,
          ),
        ],
      ),
    );
  }
}

class TextAndImage extends StatelessWidget {
  final AnimationController animationController;

  TextAndImage({
    @required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset(-1,0),
                end: Offset.zero,
              ).animate(animationController),
              child: FadeTransition(
                opacity: animationController,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.centerLeft,
                  child: Text('An interesting title',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Align(
                  heightFactor: 0.826,
                  alignment: Alignment.topLeft,
                  child: Image.network(
                    'https://images.pexels.com/photos/320014/pexels-photo-320014.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=400',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class Bottom extends StatelessWidget {
  final AnimationController animationController;

  Bottom({
    @required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(0,1),
        end: Offset.zero,
      ).animate(animationController),
      child: FadeTransition(
        opacity: animationController,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.all(10),
            height: 80,
            color: Theme.of(context).primaryColor,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Nice Kitty!',
                  style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).primaryTextTheme.headline5.color,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(1,1),
                        blurRadius: 2
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



