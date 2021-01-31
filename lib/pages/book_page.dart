import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/models/api_book.dart';
import 'package:shelf/providers/api_search_provider.dart';
import 'package:shelf/widgets/add_to_shelf_builder.dart';
import 'package:shelf/widgets/info_chip.dart';
import 'package:shelf/widgets/info_chip_text.dart';
import 'package:url_launcher/url_launcher.dart';

class BookPage extends StatelessWidget {
  static final String routeName = '/book';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    APIBook book = Provider.of<APISearchPRovider>(context, listen: false)
        .getSelectedBook();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        actions: [
          IconButton(
            icon: Icon(Icons.note_add_rounded),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  builder: (ctx) {
                    return AddToShelfBuilder(book);
                  });
            },
          )
        ],
        title: Text(
          book.title,
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white70,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    book.thumbnail,
                    width: 140,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        book.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      ...book.authors.map((e) => Text(
                            e,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                            ),
                          )),
                      SizedBox(height: 15),
                      Text(book.subtitle),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Divider(),
            ),
            Text(
              'Info',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Wrap(
              children: [
                InfoChip(Icons.data_usage_outlined, book.publishedDate),
                InfoChip(Icons.pages_outlined, book.pageCount.toString()),
                InfoChip(Icons.language_outlined, book.language),
                InfoChip(Icons.rate_review,
                    book.maturityRating.replaceAll('_', ' ')),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Divider(),
            ),
            Text(
              'Categories',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Wrap(
              children: [
                ...book.categories.map(
                  (c) => InfoChip(Icons.category_outlined, c),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Divider(),
            ),
            Text(
              'Links',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Wrap(
              children: [
                GestureDetector(
                  onTap: () async {
                    await launch(book.infoLink);
                  },
                  child: InfoChip(Icons.info_outline, 'Information'),
                ),
                GestureDetector(
                  onTap: () async {
                    await launch(book.canonicalVolumeLink);
                  },
                  child: InfoChip(Icons.bookmark_border_rounded, 'Volume'),
                ),
                GestureDetector(
                  onTap: () async {
                    await launch(book.previewLink);
                  },
                  child: InfoChip(Icons.preview_outlined, 'Preview'),
                ),
                GestureDetector(
                  onTap: () async {
                    await launch(book.webReaderLink);
                  },
                  child: InfoChip(Icons.read_more, 'Reader'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Divider(),
            ),
            Text(
              'Description',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 15),
            Text(
              book.description,
              style: TextStyle(fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Divider(),
            ),
            Text(
              'Industry Identifiers',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Wrap(
              children: [
                ...book.industryIdentifiers.map(
                  (i) =>
                      InfoChipText(i.type.replaceAll('_', ' '), i.identifier),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
