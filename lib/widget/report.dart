import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:ampedmedia_flutter/provider/report_provider.dart';
import 'package:ampedmedia_flutter/widget/showalert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Report extends StatefulWidget {
  final int? channel_id;
  final int? material_id;

  const Report({super.key, this.channel_id, this.material_id});
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  void dispose() {
    _reportDetailsController.dispose();
    super.dispose();
  }

  final reportFieldKey = GlobalKey<FormFieldState>();
  String _selectedOption = 'Select an option';
  final _reportDetailsController = TextEditingController();

  void _showReportOptionsBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Report Options',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              ...[
                {'label': 'Hate Speech', 'icon': Icons.report_problem},
                {'label': 'Gender Violation', 'icon': Icons.person_remove},
                {'label': 'Inappropriate Age Range', 'icon': Icons.person},
                {'label': 'Stereotype', 'icon': Icons.group_add},
                {'label': 'Discrimination', 'icon': Icons.remove_circle},
                {'label': 'Unspecified', 'icon': Icons.report}
              ]
                  .map((option) => ListTile(
                        leading: Icon(option['icon'] as IconData),
                        title: Text(option['label'].toString()),
                        onTap: () {
                          setState(() {
                            _selectedOption = option['label'].toString();
                          });
                          print(_selectedOption);
                          Navigator.of(context).pop();
                          _showReportDetailsBottomSheet();
                        },
                      ))
                  .toList(),
            ],
          ),
        );
      },
    );
  }

  void _showReportDetailsBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // This allows the bottom sheet to expand
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context)
              .viewInsets, // Adjusts the padding to avoid the keyboard
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.0),
                  Text(
                    'Report',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Please enter any additional details relevant to your report.',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _reportDetailsController,
                    key: reportFieldKey,
                    decoration: InputDecoration(
                      hintText: 'Additional details',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'desription can not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      reportItemFunc();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Send Report',
                        style: TextStyle(
                          color: Color(0xFF00A19A),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: _showReportOptionsBottomSheet,
            child: Row(
              children: [
                Icon(Icons.report, size: 24.0, color: Colors.green),
                SizedBox(width: 8.0),
                Text('Report', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //sign up method
  void reportItemFunc() async {
    print('email..............................................');
    if (!reportFieldKey.currentState!.validate()) {
      return;
    }
    final token = Provider.of<Auth>(context, listen: false).token;
    if (token == null) {
      // ShowAlert(message: '!');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unautherized'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }
    ;
    final reportData = {
      "report_type": _selectedOption,
      "report_desc": _reportDetailsController.text,
      "material_id": widget.channel_id,
      "channel_id": widget.material_id,
    };
    print(reportData.entries);
    try {
      await Provider.of<ReportProvider>(context, listen: false)
          .reportItem(token, reportData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('report is done!'),
          duration: Duration(seconds: 3),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
