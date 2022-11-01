import 'package:flutter/material.dart';
import 'package:stock_market_chart/shared/colors.dart';

class ElasticTabbarWidget extends StatefulWidget {
  const ElasticTabbarWidget({
    Key? key,
    required this.currentTab,
    required this.tabs,
    required this.color,
    required this.onChanged,
  }) : super(key: key);

  final Function(int) onChanged;
  final int currentTab;
  final Color color;
  final List<String> tabs; //

  @override
  ElasticTabbarWidgetState createState() => ElasticTabbarWidgetState();
}

class ElasticTabbarWidgetState extends State<ElasticTabbarWidget>
    with SingleTickerProviderStateMixin {
  final int initPage = 0;
  final double _padding = 20;

  int currentPage = 0;
  List<GlobalKey> tabKeys = [];
  double indicatorWidth = 0;

  late double _dragPadding;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _dragPadding = 0;
    currentPage = widget.currentTab;

    for (var i = 0; i < widget.tabs.length; i++) {
      var tabKey = GlobalKey();
      tabKeys.add(tabKey);
    }

    _controller = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
    )..addListener(() {
        setState(() {
          _dragPadding = _animation.value;
        });
      });

    WidgetsBinding.instance.addPostFrameCallback((_) => _tabListener());
  }

  void _tabListener() {
    var padding = 0.0;
    for (var i = 0; i < currentPage; i++) {
      final RenderBox renderBoxRed =
          tabKeys[i].currentContext?.findRenderObject() as RenderBox;
      final sizeTab = renderBoxRed.size;
      padding += sizeTab.width + _padding;
    }

    final renderBoxRed =
        tabKeys[currentPage].currentContext?.findRenderObject() as RenderBox;
    final sizeTab = renderBoxRed.paintBounds;
    indicatorWidth = sizeTab.size.width;
    setState(() {});

    _runAnimation(
      _dragPadding,
      padding,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _runAnimation(double oldA, double newA) {
    _animation = Tween(
      begin: oldA,
      end: newA,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const ElasticOutCurve(0.9),
    ));

    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Align(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: _dragPadding > 0 ? _dragPadding : 0,
                  right: 2.0,
                  bottom: 2.0,
                  top: 35.0),
              child: Container(
                height: 3,
                width: indicatorWidth,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
            ),
            Row(
              children: widget.tabs.map((t) {
                int index = widget.tabs.indexOf(t);

                return _buildButton(index, t);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(int index, String t) {
    return Padding(
      padding: EdgeInsets.only(right: _padding),
      child: InkWell(
        key: tabKeys[index],
        onTap: () {
          currentPage = index;
          widget.onChanged(index);
        },
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: AnimatedDefaultTextStyle(
              duration: kThemeAnimationDuration,
              style: TextStyle(
                  inherit: true,
                  color: currentPage == index ? widget.color : Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
              child: Text(t),
            )),
      ),
    );
  }
}
