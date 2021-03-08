import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/api_search_provider.dart';
import 'package:shelf/widgets/api_book_list_item.dart';

class AddBookPage extends StatelessWidget {
  static final String routeName = '/addBook';
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Add Books on your Shelf',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Colors.white70,
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: TextField(
                    controller: _textEditingController,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                      labelText: 'Search for books on your shelf',
                      hintText: 'Normal People ...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: context.watch<APISearchPRovider>().isLoading
                      ? null
                      : () async {
                          print('text: ${_textEditingController.text}');
                          Provider.of<APISearchPRovider>(context, listen: false)
                              .searchForABook(_textEditingController.text
                                  .replaceAll(' ', '+'));
                          FocusScope.of(context).unfocus();
                        },
                ),
              ],
            ),
          ),
          if (context.watch<APISearchPRovider>().books.length == 0 ||
              context.watch<APISearchPRovider>().isLoading)
            SizedBox(height: 100),
          if (context.watch<APISearchPRovider>().books.length == 0 &&
              !context.watch<APISearchPRovider>().isLoading)
            Image.asset(
              'assets/pics/bibliophile.png',
              width: MediaQuery.of(context).size.width * 0.7,
            ),
          if (context.watch<APISearchPRovider>().isLoading)
            Center(child: CircularProgressIndicator()),
          if (context.watch<APISearchPRovider>().books.length > 0 &&
              !context.watch<APISearchPRovider>().isLoading)
            Expanded(
              child: ListView.builder(
                itemCount:
                    Provider.of<APISearchPRovider>(context, listen: false)
                        .books
                        .length,
                primary: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) =>
                    APIBookListItem(
                        book: Provider.of<APISearchPRovider>(context,
                                listen: false)
                            .books[index]),
              ),
            ),
        ],
      ),
    );
  }
}
