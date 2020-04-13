import 'package:flutter/material.dart';
import 'package:humwell_signup/consts.dart';
import 'package:humwell_signup/data/models/models.dart';
import 'package:humwell_signup/ui/custom_widgets/custom_widget.dart';
import 'package:humwell_signup/ui/home.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';


class LastPage extends StatelessWidget {

  final int maxPages;

  const LastPage({Key key, this.maxPages}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double progress = (Provider.of<AnswerModel>(context).progress / maxPages);
    int progress_percent = (progress * 100).round();
    
    return Scaffold(
      body: Stack(
        children: <Widget>[

          // backgroud image
          Container(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/images/signup_background.png",
              fit: BoxFit.fitWidth,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(padding_xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                CircularPercentIndicator(
                  radius: 120.0,
                  percent: progress,
                  animation: true,
                  animationDuration: 500,
                  circularStrokeCap: CircularStrokeCap.round,
                  center: (progress != 1)? 
                  Text(
                    "$progress_percent%",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Theme.of(context).accentColor,
                    ),
                  )
                  : Icon(
                      Icons.done_all,
                      size: 54.0,
                      color: Theme.of(context).accentColor,
                    ),
                  lineWidth: 10.0,
                  progressColor: Theme.of(context).primaryColor,
                ),

                SizedBox(height: size_l),

                Text(
                  (progress == 100)?
                    "Your profile is completed" : 
                    "Your profile is $progress_percent% completed.",
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
                  onTap: (){
                    Navigator.popUntil(context, ModalRoute.withName(HomePage.id));
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}