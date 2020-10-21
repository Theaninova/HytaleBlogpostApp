import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

Future<Widget> getBlogpostList(String url) async {
  var response = await http.get(url);

  var document = parse(response.body);
  var entries = document.getElementsByClassName('postWrapper');

  var out = List<Widget>();

  for (var entry in entries) {
    // Text(entry.getElementsByClassName('post__details__heading').first.text.trim())

    var imageUrl = entry
        .getElementsByClassName('post__image__frame')
        .first
        .firstChild
        .attributes
        .entries
        .first
        .value;
    var headline = entry
        .getElementsByClassName('post__details__heading')
        .first
        .text
        .trim();
    var contentBody =
        entry.getElementsByClassName('post__details__body').first.text.trim();

    out.add(Container(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Image.network(
                imageUrl,
                fit: BoxFit.fitHeight,
              ),
            ),
            Flexible(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      headline,
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                      softWrap: true,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.fade,
                    )),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      contentBody,
                      softWrap: true,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.fade,
                    )),
              ],
            )),
          ],
        ),
      ),
    ));
  }

  return ListView(
    padding: const EdgeInsets.all(8),
    children: out,
  );
}
