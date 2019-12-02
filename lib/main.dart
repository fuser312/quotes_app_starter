import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'loader.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

void main() {
  runApp(MaterialApp(
    home: QuotesPage(),
  ));
}

class QuotesPage extends StatefulWidget {
  @override
  _QuotesPageState createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  bool loading = false;

  Future<Map> getQuotes() async {
    isLoading();
    Response response = await get("https://favqs.com/api/qotd");
    loading = false;
    Map<String, dynamic> mapOfQuotes = jsonDecode(response.body);
    return mapOfQuotes;
  }

  isLoading() {
    loading = true;
    setState(() {});
  }

  String quoteText = "Fetching Data";
  String authorName = "Press the button below to get a new quote.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text("Fuser Quotes App"),
        centerTitle: true,
        backgroundColorStart: Colors.red,
        backgroundColorEnd: Colors.blue,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.green, Colors.blue]),
          ),
          child: loading
              ? Loader()
              : Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Column(
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
                              fontSize: 20,
                            ),
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
                              Map quoteMap = await getQuotes();
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
      ),
    );
  }
}
