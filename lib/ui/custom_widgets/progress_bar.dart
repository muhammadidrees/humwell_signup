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
      padding: EdgeInsets.only(left: 32.0, right: 32.0, bottom: 32.0, top: 64.0),
      child: LinearProgressIndicator(
        value: progress / maxPages,
        backgroundColor: Colors.blueGrey.withOpacity(0.2),
        valueColor: AlwaysStoppedAnimation(Colors.green),
      ),
    );
  }
}