import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/providers/post_provider.dart';
import 'package:shelf/widgets/create_post/images_selector.dart';

class CreatePostPage extends StatefulWidget {
  static final String routeName = 'CreatePost_page';

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController textController = TextEditingController();
  late PostProvider postProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    postProvider = Provider.of<PostProvider>(context);
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Create',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          backgroundColor: Colors.white70,
          iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
              width: size.width,
            ),
            Container(
              width: size.width * 0.95,
              child: TextField(
                controller: textController,
                minLines: 1,
                maxLines: 7,
                enabled: !postProvider.isUploading,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  labelText: 'Share Ideas, opinions or a recommendation',
                  hintText: 'Share Ideas, opinions or a recommendation',
                ),
              ),
            ),
            SizedBox(height: 20),
            ImageSelector(),
            SizedBox(height: 20),
            if (postProvider.isUploading) CircularProgressIndicator(),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                postProvider.createPost(
                  textController.text.trim(),
                  Provider.of<AuthProvider>(context, listen: false).uid!,
                );
                textController.clear();
                Navigator.of(context).pop();
              },
              child: Text('Create'),
            ),
          ],
        ));
  }
}
