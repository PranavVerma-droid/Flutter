import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookListPage(),
    );
  }
}

class BookListPage extends StatefulWidget {
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  final _books = <Book>[
    Book('Charlotte\'s Web', 'E.B. White'),
    Book('1984', 'George Orwell'),
    Book('The Catcher in the Rye', 'J.D. Salinger'),
  ];

  void _addBook() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddBookPage()),
    );

    if (result != null) {
      setState(() {
        _books.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book List (By Pranav Verma)'),
      ),
      body: ListView.builder(
        itemCount: _books.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_books[index].title),
            subtitle: Text(_books[index].author),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addBook,
        tooltip: 'Add Book',
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddBookPage extends StatefulWidget {
  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  void _saveBook() {
    final title = _titleController.text;
    final author = _authorController.text;

    if (title.isNotEmpty && author.isNotEmpty) {
      final book = Book(title, author);
      Navigator.pop(context, book);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(
                labelText: 'Author',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveBook,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class Book {
  final String title;
  final String author;

  Book(this.title, this.author);
}
