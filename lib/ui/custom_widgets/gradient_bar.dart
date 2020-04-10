part of 'custom_widget.dart';

const double _kLinearProgressIndicatorHeight = 6.0;
const int _kIndeterminateLinearDuration = 1800;

class GradientProgressIndicator extends StatefulWidget {
  const GradientProgressIndicator({
    this.key,
    this.value,
    this.gradient, 
    this.backgroundColor,
  });

  final Key key;
  final double value;
  final LinearGradient gradient;
  final Color backgroundColor;

  @override
  _GradientProgressIndicatorState createState() => _GradientProgressIndicatorState();
}

class _GradientProgressIndicatorState extends State<GradientProgressIndicator> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> pAnimation;
  List<Color> colors = [];

  double prevValue = 0.0;

  CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();

    assert(widget.gradient != null, 'Please set the gradient!');
    assert(widget.gradient.colors.length == 2, 'gradient must have two colors only');

    _setColorsArray();

    _controller = AnimationController(
      duration: const Duration(milliseconds: _kIndeterminateLinearDuration),
      vsync: this,
    );

    _setControllerListener();

    curvedAnimation = CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    pAnimation = Tween<double>(begin: prevValue, end: widget.value ?? 1.0).animate(curvedAnimation);
    prevValue = widget.value ?? 0;

    _controller.forward();
  }

  void _setColorsArray() {
    colors.clear();
    colors.addAll(widget.gradient.colors);
  }

  void _setControllerListener() {
    if (widget.value == null) {
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.dismissed && widget.value == null) {
          _controller.forward();
        } else if (status == AnimationStatus.completed && widget.value == null) {
          _controller.reverse();
        }
      });
    }
  }

  @override
  void didUpdateWidget(GradientProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    _setColorsArray();

    _setControllerListener();

    if (widget.value == null && !_controller.isAnimating) {
      _controller.reset();
    } else if (widget.value != null) {
      pAnimation = Tween<double>(begin: prevValue, end: widget.value).animate(curvedAnimation);
      _controller
        ..reset()
        ..forward();
      prevValue = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void stopAnimation() {
    _controller.stop();
  }

  Widget _buildIndicator(BuildContext context, double animationValue, double maxWidth) {
  
    return Stack(
      children: <Widget>[
        Container(
          constraints: BoxConstraints.tightFor(
            width: maxWidth,
            height: _kLinearProgressIndicatorHeight,
          ),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
          ),
        ),

        Container(
          constraints: BoxConstraints.tightFor(
            width: widget.value * maxWidth,
            height: _kLinearProgressIndicatorHeight,
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: widget.gradient.begin,
                  end: widget.gradient.end,
                  stops: <double>[
                    0.0,
                    1.0,
                  ],
                  colors: colors)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBuilder(
          key: widget.key,
          animation: pAnimation,
          builder: (BuildContext context, Widget child) {
            return _buildIndicator(context, pAnimation.value, constraints.maxWidth);
          },
        );
      }
    );
  }
}