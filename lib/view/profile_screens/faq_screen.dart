import 'package:ampedmedia_flutter/model/faq.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  late List<FAQItem> general;
  late List<CustomerJourney> customerJourney;
  @override
  void initState() {
    super.initState();
    general = getFAQsByCategory("CJ");
    customerJourney = getCutomerJourneyByCategory("all");
  }

  String selectedAnswer = '';
  String selectedQuestion = '';
  String selectedCategory = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs'),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        toolbarHeight: 75,
        leading: InkWell(
          onTapUp: (details) {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  'Customer journey',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Colors.grey, fontSize: 30),
                ),
              ),
              Text(
                'steps to follow on AMPED Media app',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: customerJourney.length,
                itemBuilder: (context, index) {
                  // return InkWell(
                  //   onTap: () {
                  //     showDialog(
                  //       context: context,
                  //       builder: (context) {
                  //         return AlertDialog(
                  //           title: Text('${customerJourney[index].step}'),
                  //           content: Text(
                  //               customerJourney[index].description.toString()),
                  //           actions: [
                  //             TextButton(
                  //               child: const Text('Close'),
                  //               onPressed: () {
                  //                 Navigator.of(context).pop();
                  //               },
                  //             ),
                  //           ],
                  //         );
                  //       },
                  //     );
                  //   },
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(vertical: 8),
                  //     child: Text(
                  //       customerJourney[index].step,
                  //       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  //           color: Colors.green[800],
                  //           decoration: TextDecoration.underline),
                  //     ),
                  //   ),
                  // );
                  return ExpandableTextWidget(
                    description: customerJourney[index].description,
                    title: customerJourney[index].step,
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  'AMPED Media Faq',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Colors.grey,
                        fontSize: 30,
                      ),
                ),
              ),
              Text(
                'This faq provides answer to basic questions about AMPED Media',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: 30,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: general.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Q:${general[index].question}'),
                            content: Text(general[index].answer),
                            actions: [
                              TextButton(
                                child: const Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        general[index].question,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.grey,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//expandedTitle widget
class ExpandableTextWidget extends StatefulWidget {
  final String title;
  final List<String> description;

  ExpandableTextWidget({required this.title, required this.description});

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        widget.title,
        style: TextStyle(
            // fontWeight: FontWeight.bold,
            ),
      ),
      trailing: Icon(
        isExpanded ? Icons.expand_less : Icons.expand_more,
      ),
      onExpansionChanged: (expanded) {
        setState(() {
          isExpanded = expanded;
        });
      },
      children:
          widget.description.map((description) => Text(description)).toList(),
    );
  }
}
