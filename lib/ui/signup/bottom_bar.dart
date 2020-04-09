import 'package:flutter/material.dart';
import 'package:humwell_signup/ui/home.dart';

class BottomBar extends StatelessWidget {
  final bool lastPage;

  const BottomBar({
    Key key,
    @required PageController pageController, this.lastPage,
  }) : _pageController = pageController, super(key: key);

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.transparent, 
        height: (MediaQuery.of(context).size.height / 10),
        child: Stack(
          alignment: Alignment.center,
          children: [

            // go next page button
            AnimatedOpacity(
              duration: Duration(milliseconds: 200),
              opacity: lastPage? 0.0 : 1.0,
              child: Container(
                alignment: Alignment.centerRight,
                child: FlatButton.icon(
                  onPressed: (){
                    _pageController.animateToPage(
                      _pageController.page.round() + 1,
                      duration: Duration(milliseconds: 200), 
                      curve: Curves.easeIn,
                    );
                  }, 
                  icon: Text("Skip"), 
                  label: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),

            // go to home page button
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              alignment: lastPage? Alignment.centerRight : Alignment.centerLeft,
              child: FlatButton.icon(
                onPressed: (){
                  Navigator.of(context).popUntil(ModalRoute.withName(HomePage.id));
                }, 
                icon: Icon(Icons.home), 
                label: Text("Home"),
              ),
            )
          ],
        ),
      ),
    );
  }
}