import 'package:flutter/material.dart';
import 'package:humwell_signup/consts.dart';
import 'package:humwell_signup/data/models/models.dart';
import 'package:humwell_signup/ui/custom_widgets/custom_widget.dart';
import 'package:provider/provider.dart';


class LastPage extends StatelessWidget {

  final int maxPages;

  const LastPage({Key key, this.maxPages}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    int progress = ((Provider.of<AnswerModel>(context).progress / maxPages) * 100).round();
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(padding_xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              (progress == 100)?
                "Your profile is completed" : 
                "Your profile is $progress% completed.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: size_l),

            Text(
              "You can complete your profile any time by clicking the profile icon.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),

            SizedBox(height: size_l),

            CustomButton(
              text: "OK",
              icon: Icons.arrow_forward_ios,
            )
          ],
        ),
      ),
    );
  }
}