import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: const Text('Main Screen'),
          centerTitle: true,
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      backgroundColor: Colors.black),
                  onPressed: () {
                    Navigator.pushNamed(context, '/tasks');
                  },
                  child: const Text('Next')),
            ],
          ),
        ));
  }
}
