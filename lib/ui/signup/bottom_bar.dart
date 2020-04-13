import 'package:flutter/material.dart';
import 'package:humwell_signup/consts.dart';
import 'package:humwell_signup/data/models/models.dart';
import 'package:humwell_signup/ui/home.dart';
import 'package:humwell_signup/ui/signup/last_page.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  final int maxPages;
  final List<Question> quesiton;
  
  const BottomBar({
    Key key,
    @required PageController pageController, this.maxPages, this.quesiton,
  }) : _pageController = pageController, super(key: key);

  final PageController _pageController;

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  bool keyboardShowing = false;

  @override
  void initState() {

    KeyboardVisibilityNotification().addNewListener(
      onChange: (value){
        setState(() {
          keyboardShowing = value;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[


          !keyboardShowing?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (int i = 0; i < widget.maxPages; i++)
                Hero(
                  tag: "question_$i",
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: ((widget._pageController.page?? 0) == i)? 
                          EdgeInsets.only(bottom: padding_xl) : 
                          EdgeInsets.only(bottom: 0.0),
                    padding: EdgeInsets.symmetric(horizontal: padding_xs),
                    child: GestureDetector(
                      child: Icon(
                        Provider.of<AnswerModel>(context).getAnswer(widget.quesiton[i]) != null?
                            Icons.check_circle : 
                            Icons.do_not_disturb_on,
                        color: Provider.of<AnswerModel>(context).getAnswer(widget.quesiton[i]) != null?
                              Theme.of(context).accentColor : 
                              buttonDisabledColor,
                        size: 16.0,
                      ),
                      onTap: (){
                        widget._pageController.jumpToPage(i);
                      },
                    )
                  ),
                ),
            ],
          ) : Container(),

          Container(
            color: Colors.transparent, 
            height: (MediaQuery.of(context).size.height / 10),
            child: Stack(
              children: [

                // go next page button
                AnimatedOpacity(
                  duration: Duration(milliseconds: 200),
                  // opacity: lastPage? 0.0 : 1.0,
                  opacity: 1.0,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: FlatButton.icon(
                      onPressed: (){
                        print(widget._pageController.page.round());
                        print(widget.maxPages - 1);
                        if(widget._pageController.page.round() >= widget.maxPages - 1 && widget.maxPages - 1 > 0){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LastPage(maxPages: widget.maxPages)));
                        } else {
                          widget._pageController.animateToPage(
                            widget._pageController.page.round() + 1,
                            duration: Duration(milliseconds: 200), 
                            curve: Curves.easeIn,
                          );
                        }
                      }, 
                      icon: Text("Skip"), 
                      label: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),

                // go to home page button
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  // alignment: lastPage? Alignment.centerRight : Alignment.centerLeft,
                  alignment: Alignment.centerLeft,
                  child: FlatButton.icon(
                    onPressed: (){
                      Navigator.of(context).popUntil(ModalRoute.withName(HomePage.id));
                    }, 
                    icon: Icon(Icons.home), 
                    label: Text("Home"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}