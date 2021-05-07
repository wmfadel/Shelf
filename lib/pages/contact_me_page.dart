import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ContactMePage extends StatefulWidget {
  static final String routeName = 'ContactMe_page';

  @override
  _ContactMePageState createState() => _ContactMePageState();
}

class _ContactMePageState extends State<ContactMePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Me',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Colors.white70,
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Topics',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
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
              SizedBox(height: 75),
              Center(
                child: MaterialButton(
                  onPressed: isSending
                      ? null
                      : canSend()
                          ? () async {
                              String subject = '';
                              for (int i = 0; i < selectedTopics.length; i++) {
                                if (selectedTopics[i])
                                  subject += '${topics[i]}, ';
                              }

                              final Email email = Email(
                                body: textController.text.trim(),
                                subject: subject,
                                recipients: ['mailto:fadel24997@gmail.com'],
                                isHTML: false,
                              );
                              setState(() {
                                isSending = true;
                              });
                              await FlutterEmailSender.send(email);
                              selectedTopics = List<bool>.generate(
                                  topics.length, (_) => false);
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool canSend() {
    if (selectedTopics.contains(true) && textController.text.trim().isNotEmpty)
      return true;
    return false;
  }
}
