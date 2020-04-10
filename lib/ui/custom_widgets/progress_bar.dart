part of 'custom_widget.dart';

class PageViewProgress extends StatelessWidget {
  const PageViewProgress({
    Key key,
    @required this.maxPages, double progress,
  }) :  this.progress = progress?? 0.0,
        super(key: key);

  final double progress;
  final int maxPages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: padding_xl, right: padding_xl, bottom: padding_xl, top: padding_xxl),
      child: GradientProgressIndicator(
        value: progress / maxPages,
        backgroundColor: Colors.white70,
        gradient: LinearGradient(
          colors: signupProgressGradient,
        ),
      ),
    );
  }
}