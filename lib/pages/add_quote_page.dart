import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/models/quote.dart';
import 'package:shelf/providers/auth_provider.dart';

class AddQuotePage extends StatelessWidget {
  static final String routeName = 'AddQuote_page';

  final TextEditingController textController = TextEditingController();
  final TextEditingController bookController = TextEditingController();
  final TextEditingController pageController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'Add Quotes',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Colors.white70,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 20),
              TextField(
                controller: textController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Quote text',
                  labelText: 'Quote',
                ),
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: bookController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Book Title',
                        labelText: 'Book',
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: pageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Page number',
                        labelText: 'Page',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                controller: authorController,
                decoration: InputDecoration(
                  hintText: 'Author name',
                  labelText: 'Author',
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                child: Text('Add New Quote'),
                onPressed: () {
                  Quote quote = Quote(
                    text: textController.text.trim(),
                    author: authorController.text.trim(),
                    book: bookController.text.trim(),
                    date: Timestamp.now(),
                    page: pageController.text.trim(),
                  );
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(
                          Provider.of<AuthProvider>(context, listen: false).uid)
                      .collection('quotes')
                      .add(quote.toJson());
                  textController.clear();
                  bookController.clear();
                  pageController.clear();
                  authorController.clear();
                },
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
