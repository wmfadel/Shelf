import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/models/market_book.dart';
import 'package:shelf/providers/market_provider.dart';
import 'package:shelf/widgets/market/book_photos.dart';
import 'package:shelf/widgets/market/market_user.dart';

class BookOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MarketProvider marketProvider = Provider.of<MarketProvider>(context);
    MarketBook? book = marketProvider.getActiveBook();
    if (book == null) return Container();

    return Container(
      margin: EdgeInsets.fromLTRB(10, 8, 50, 10),
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.only(
            left: 4,
            right: 4,
            top: 4,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          //  height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      book.title!,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        print('close');
                        marketProvider.setActiveBook(null);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.red,
                      ))
                ],
              ),
              SizedBox(height: 5),
              BookPhotos(
                photos: List.from(book.photos!)..insert(0, book.thumbnail!),
              ),
              SizedBox(height: 8),
              MarketUser(
                id: book.userId!,
                name: book.userName!,
                photo: book.userPhoto!,
                email: book.email!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
