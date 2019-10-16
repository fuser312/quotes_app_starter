import 'dart:convert';
import 'quote_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(
    MaterialApp(
      home: QuotesPage(),
    )
  );
}


class QuotesPage extends StatefulWidget {
  @override
  _QuotesPageState createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {

  Future<Map> Quotes()async{
    Response response = await get("https://favqs.com/api/qotd");

    Map<String, dynamic> mapOfQuotes = jsonDecode(response.body);
    print(mapOfQuotes['quote']['author']);
    return mapOfQuotes;
  }

  String quoteText = "Quote HERE";
  String authorName = "Author HERE";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.only(bottom: 16),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    quoteText,
                    style: TextStyle(
                        fontSize: 20, ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  authorName,
                  style: TextStyle(
                      color: Colors.red,
                      fontStyle: FontStyle.italic,
                      fontSize: 16),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.topLeft,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.red,
                      size: 24,
                    ),
                    onPressed: () async {
                      Map quoteMap = await Quotes();

                      authorName = quoteMap['quote']['author'];
                      quoteText = quoteMap['quote']['body'];
                      setState(() {});
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
