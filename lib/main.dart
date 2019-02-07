import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final workPair = WordPair.random();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Startup Name Generator',
      theme: ThemeData(primaryColor: Colors.white),
      home: RandomWord(),
    );
  }
}

class RandomWord extends StatefulWidget {
  @override
  _RandomWordState createState() => _RandomWordState();
}

class _RandomWordState extends State<RandomWord> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _save = Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        final Iterable<ListTile> tilesList = _save.map((WordPair pair) {
          return ListTile(
            title: Text(
              pair.asPascalCase,
              style: _biggerFont,
            ),
          );
        });
        final List<Widget> dividers = ListTile.divideTiles(
          context: context,
          tiles: tilesList,
        ).toList();

        return new Scaffold(
          appBar: AppBar(
            title: Text('Saved Suggestions'),
          ),
          body: new ListView(children: dividers),
        );
      },
    ));
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext, index) {
          if (index.isOdd) {
            return new Divider();
          }

          final int indexOf = index ~/ 2;

          if (indexOf >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[indexOf]);
        });
  }

  Widget _buildRow(WordPair word) {
    final bool alreadySaved = _save.contains(word);

    return ListTile(
      title: Text(
        word.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _save.remove(word);
          } else {
            _save.add(word);
          }
        });
      },
    );
  }
}
