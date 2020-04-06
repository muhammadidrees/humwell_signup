import 'package:flutter/material.dart';
import 'package:humwell_signup/ui/home.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key key,
    @required PageController pageController,
  }) : _pageController = pageController, super(key: key);

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.transparent, 
        height: (MediaQuery.of(context).size.height / 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            // go to home button
            FlatButton.icon(
              onPressed: (){
                Navigator.of(context).popUntil(ModalRoute.withName(HomePage.id));
              }, 
              icon: Icon(Icons.home), 
              label: Text("Home"),
            ),

            // go next page button
            FlatButton.icon(
              onPressed: (){
                _pageController.animateToPage(
                  _pageController.page.round() + 1,
                  duration: Duration(milliseconds: 200), 
                  curve: Curves.easeIn,
                );
              }, 
              icon: Text("Skip"), 
              label: Icon(Icons.arrow_forward_ios),
            )
          ],
        ),
      ),
    );
  }
}