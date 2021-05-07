import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/auth_provider.dart';

class SendFeedBack extends StatefulWidget {
  @override
  _SendFeedBAckState createState() => _SendFeedBAckState();
}

class _SendFeedBAckState extends State<SendFeedBack> {
  List<String> topics = [
    'Hiring',
    'Problem',
    'Suggestion',
    'Info',
    'Feature Request',
    'Complaint'
  ];
  List<bool> selectedTopics = List<bool>.generate(6, (_) => false);
  final TextEditingController textController = TextEditingController();
  bool isSending = false;
  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  bool canSend() {
    if (selectedTopics.contains(true) && textController.text.trim().isNotEmpty)
      return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Wrap(
            spacing: 10,
            alignment: WrapAlignment.center,
            children: List<Widget>.generate(
              topics.length,
              (int index) {
                return ChoiceChip(
                  label: Text(topics[index]),
                  selected: selectedTopics[index],
                  onSelected: (bool selected) {
                    setState(() {
                      selectedTopics[index] = selected;
                    });
                  },
                );
              },
            ).toList(),
          ),
          SizedBox(height: 20),
          TextField(
            controller: textController,
            minLines: 1,
            maxLines: 10,
            enabled: !isSending,
            autocorrect: true,
            onChanged: (String? text) {
              setState(() {});
            },
            decoration: InputDecoration(
              hintText: 'Tell us what you want',
              labelText: 'Tell us what you want',
            ),
          ),
          SizedBox(height: 50),
          Center(
            child: MaterialButton(
              onPressed: isSending
                  ? null
                  : canSend()
                      ? () async {
                          List<String> subject = [];
                          for (int i = 0; i < selectedTopics.length; i++) {
                            if (selectedTopics[i]) subject.add(topics[i]);
                          }
                          AuthProvider authProvider =
                              Provider.of<AuthProvider>(context, listen: false);
                          setState(() {
                            isSending = true;
                          });
                          await FirebaseFirestore.instance
                              .collection('feedback')
                              .add({
                            'time': Timestamp.now(),
                            'user': authProvider.uid,
                            'name': authProvider.name,
                            'email': authProvider.email,
                            'photo': authProvider.photo,
                            'text': textController.text.trim(),
                            'topics': subject,
                          });

                          selectedTopics =
                              List<bool>.generate(topics.length, (_) => false);
                          textController.clear();
                          setState(() {
                            isSending = false;
                          });
                        }
                      : null,
              minWidth: 250,
              color: Theme.of(context).primaryColor,
              disabledColor: Colors.grey.shade400,
              disabledTextColor: Colors.white,
              textColor: Colors.white,
              height: 45,
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: isSending ? CircularProgressIndicator() : Text('Send'),
            ),
          )
        ],
      ),
    );
  }
}
