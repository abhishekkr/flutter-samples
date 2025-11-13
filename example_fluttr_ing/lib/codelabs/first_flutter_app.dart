import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _favorite = Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext _context, int idx) {
          if (idx.isOdd) {
            return Divider();
          }

          final int index = idx ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadyFavorite = _favorite.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadyFavorite ? Icons.favorite : Icons.favorite_border,
        color: alreadyFavorite ? Colors.orange : null,
      ),
      onTap: () {
        setState(() {
          alreadyFavorite ? _favorite.remove(pair) : _favorite.add(pair);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fluttr-ing'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushFavorited)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushFavorited() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return _favoriteScaffold(context);
        },
      ),
    );
  }

  Widget _favoriteScaffold(BuildContext context) {
    final List<Widget> favorites = _favoriteList(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: ListView(children: favorites),
    );
  }

  List<Widget> _favoriteList(BuildContext context) {
    final Iterable<ListTile> tiles = _favoriteTiles();
    return ListTile.divideTiles(context: context, tiles: tiles).toList();
  }

  Iterable<ListTile> _favoriteTiles() {
    return _favorite.map(
      (WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      },
    );
  }
}
