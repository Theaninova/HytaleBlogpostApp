import 'package:flutter/material.dart';
import 'package:hytale/blogpost_network.dart';

class BlogpostEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: getBlogpostList('https://www.hytale.com/'), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Press button to start.');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Text('Awaiting result...');
          case ConnectionState.done:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            return snapshot.data;
        }
        return null; // unreachable
      },
    );
  }
}