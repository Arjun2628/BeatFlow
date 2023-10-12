import 'package:flutter/material.dart';

class PlaySong extends StatelessWidget {
  const PlaySong({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.amber,
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Expanded(
                    child: Container(
                      color: Colors.amber,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.lightBlue,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.red,
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
