part of 'custom_widget.dart';

class CustomButton extends StatelessWidget {

  final String text;

  /// An icon to be placed at the center right of button
  final IconData icon;

  /// Disable button i.e. set to a dimmer color
  final bool disable;

  final Function onTap;

  const CustomButton({
    Key key, 
    this.icon,
    bool disable, 
    @required this.text, 
    this.onTap,
  }) :  this.disable = disable?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
      onTap: disable? (){} : onTap,

      child: FractionallySizedBox(
        widthFactor: 0.5,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: padding_s, horizontal: padding_l),
          decoration: BoxDecoration(
            color: disable? buttonDisabledColor : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(50.0)
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),

              icon == null? Container()
              : Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.all(padding_xs),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.0)
                    ),
                    child: Icon(
                      icon,
                      size: 16.0,
                      color: disable? buttonDisabledColor : Theme.of(context).accentColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}