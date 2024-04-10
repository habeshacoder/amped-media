import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:ampedmedia_flutter/provider/channelcreationprovider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class SubscriptionPlanPage extends StatefulWidget {
  @override
  _SubscriptionPlanPageState createState() => _SubscriptionPlanPageState();
}

class _SubscriptionPlanPageState extends State<SubscriptionPlanPage> {
  List<SubscriptionPlan> subscriptionPlans = [];
  bool isSendingCreateProfileRequest = false;
  void showalert(String message, context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('an error occured'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('okay'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Subscription Plans'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < subscriptionPlans.length; i++)
              SubscriptionPlanForm(
                plan: subscriptionPlans[i],
                onDelete: () {
                  setState(() {
                    subscriptionPlans.removeAt(i);
                  });
                },
              ),
            Row(
              mainAxisAlignment: subscriptionPlans.length == 0
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      subscriptionPlans.add(SubscriptionPlan());
                    });
                  },
                  child: Container(
                    margin: subscriptionPlans.length == 0
                        ? EdgeInsets.only(top: 50, bottom: 15)
                        : EdgeInsets.only(top: 15, bottom: 15),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(color: Colors.grey[100]),
                    child: Text(
                      'Add Subscription Plan',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        // Text color
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
            if (subscriptionPlans.length > 0)
              InkWell(
                onTap: () {
                  _sendSubscriptionPlans(context);
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      transform: GradientRotation(348 * 3.1415927 / 180),
                      colors: [
                        Color(0xFF00A19A),
                        Color(0xFF1AECE3),
                      ],
                      stops: [0.0, 1.0],
                    ),
                  ),
                  child: Text(
                    'Submit Subscription Plans',
                    style: TextStyle(
                      color: Colors.white, // Text color
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _sendSubscriptionPlans(BuildContext context) async {
    // Convert subscriptionPlans to a list of maps
    List<Map<String, dynamic>> plansData = subscriptionPlans.map((plan) {
      return {
        'name': plan.name,
        'description': plan.description,
        'price': plan.price,
      };
    }).toList();
    print("subscription plans:${plansData}");
    if (plansData.length <= 0 || plansData.isEmpty) {
      return;
    }
    try {
      final token = Provider.of<Auth>(context, listen: false).token;
      if (token == null) {
        throw 'you are not authenticated';
      }

      final responseData =
          await Provider.of<ChannelCreationProvider>(context, listen: false)
              .addSubscriptionPlan(token, plansData);
      if (responseData == null) {
        throw 'faile to create subscription ';
      }
    } catch (error) {
      print(
          'object...........................................................$error');
      showalert('$error', context);
    }
    setState(() {
      isSendingCreateProfileRequest = false;
    });

    Navigator.of(context).pushNamed('/');
  }
}

class SubscriptionPlan {
  String name = '';
  String description = '';
  double price = 0.0;
}

class SubscriptionPlanForm extends StatelessWidget {
  final SubscriptionPlan plan;
  final VoidCallback onDelete;

  SubscriptionPlanForm({required this.plan, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              initialValue: plan.name,
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                plan.name = value;
              },
            ),
            TextFormField(
              initialValue: plan.description,
              decoration: InputDecoration(labelText: 'Description'),
              onChanged: (value) {
                plan.description = value;
              },
            ),
            TextFormField(
              initialValue: plan.price.toString(),
              decoration: InputDecoration(labelText: 'Price'),
              onChanged: (value) {
                plan.price = double.tryParse(value) ?? 0.0;
              },
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: onDelete,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(color: Colors.grey[100]),
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Text color
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
