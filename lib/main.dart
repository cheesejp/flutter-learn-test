import 'package:flutter/material.dart';
import 'package:learn_test/http_client.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CounterObject _counter = CounterObject();
  final HttpClient _httpClient = HttpClient(
      url:
          'https://raw.githubusercontent.com/cheesejp/flutter-learn-test/master/test/example.json');
  int _code;
  String _body;

  void _incrementCounter() {
    setState(() {
      _code = 0;
      _body = '';
    });

    var futureAll =
        Future.wait([_httpClient.getResponseCode(), _httpClient.getBody()]);
    futureAll.then((results) {
      setState(() {
        _code = results[0];
        _body = results[1];
        _counter.increment();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${_counter.value()}',
              style: Theme.of(context).textTheme.display1,
            ),
            Text(
              '$_code',
              style: Theme.of(context).textTheme.display1,
            ),
            Text(
              '$_body',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class CounterObject {
  int count = 0;

  void increment() => count++;
  void decrement() => count--;
  int value() => this.count;
}
