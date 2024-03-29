import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/auth_provider.dart';

class CreateShelfScreen extends StatefulWidget {
  static final String routeName = '/createShelf';

  @override
  _CreateShelfScreenState createState() => _CreateShelfScreenState();
}

class _CreateShelfScreenState extends State<CreateShelfScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  bool isPublic = true;

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          'Create new shelf',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Colors.white70,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                labelText: 'New shelf title',
                hintText: 'My New great shelf ...'),
          ),
          SizedBox(height: 10),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              labelText: 'New shelf descrption',
            ),
          ),
          SizedBox(height: 10),
          SwitchListTile(
              value: isPublic,
              title: Text(isPublic ? 'Public' : 'Private'),
              onChanged: (newValue) {
                setState(() {
                  isPublic = newValue;
                });
              }),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () async {
              String? userID =
                  Provider.of<AuthProvider>(context, listen: false).uid;
              await FirebaseFirestore.instance.collection('shelfs').doc().set({
                'name': nameController.value.text,
                'user': userID,
                'time': Timestamp.now(),
                'description': descriptionController.text.trim(),
                'isPublic': isPublic,
              });
              FocusScope.of(context).unfocus();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('New shelf created'),
                    backgroundColor: Theme.of(context).primaryColor),
              );
              nameController.clear();
              descriptionController.clear();
            },
            child: Text('Create new shelf'),
          ),
        ]),
      ),
    );
  }
}
