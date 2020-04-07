part of 'custom_widget.dart';

class PageViewProgress extends StatelessWidget {
  const PageViewProgress({
    Key key,
    @required this.maxPages, this.progress,
  }) : super(key: key);

  final double progress;
  final int maxPages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: padding_xl, right: padding_xl, bottom: padding_xl, top: padding_xxl),
      child: LinearProgressIndicator(
        value: progress / maxPages,
        backgroundColor: Colors.blueGrey.withOpacity(0.2),
        valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
      ),
    );
  }
}