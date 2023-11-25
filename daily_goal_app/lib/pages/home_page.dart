import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // do Hive stuff
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    ); 
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: const Text("Goals"),
            backgroundColor: Colors.grey,
            elevation: 0,
            centerTitle: true),
        floatingActionButton: const FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: 0,
            itemBuilder: (context, index) {
              return Container();
            }));
  }
}
