import 'package:flutter/material.dart';
import 'package:flutter_motion_demo/models/receipe_model.dart';
import 'package:flutter_motion_demo/routers/motion_animator.dart';

class ReceipeDetailsScreen extends StatefulWidget {
  const ReceipeDetailsScreen({Key? key, required this.receipe}) : super(key: key);

  final ReceipeModel receipe;

  @override
  State<ReceipeDetailsScreen> createState() => _ReceipeDetailsScreenState();
}

class _ReceipeDetailsScreenState extends State<ReceipeDetailsScreen> {
  bool _showDirections = false;
  int _index = 0;
  int _previousIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          _header(),
          Expanded(child: _currentView()),
          Container(
            color: Colors.grey[200],
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: _actionButton(),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Stack(
      children: [
        Image.network(
          widget.receipe.image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 150,
        ),
        Align(
          alignment: Alignment.topRight,
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 50,
            color: Colors.black.withOpacity(0.5),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.receipe.name,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                ),
                Text(
                  widget.receipe.author,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _currentView() {
    return MotionAnimator().sharedAxisWidgetTransition(
      reverse: !_showDirections,
      child: _showDirections ? _directionsView() : _ingredientsView(),
    );
  }

  Widget _ingredientsView() {
    List<Widget> list = [];
    for (int i = 0; i < widget.receipe.ingredients.length; i++) {
      list.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${i + 1}.', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                widget.receipe.ingredients[i],
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      );

      if (i != widget.receipe.ingredients.length - 1) {
        list.add(const SizedBox(height: 20));
      }
    }
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        const Center(
          child: Text(
            'Ingredients',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 20),
        ...list,
      ],
    );
  }

  Widget _directionsView() {
    return Row(
      children: [
        const SizedBox(width: 20),
        SizedBox(width: 80, child: _stepper()),
        Expanded(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Directions',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(child: _directionCard()),
            ],
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  Widget _stepper() {
    List<Step> children = [];
    for (int i = 0; i < widget.receipe.directions.length; i++) {
      children.add(
        Step(
          isActive: _index == i,
          title: const SizedBox.shrink(),
          content: const SizedBox.shrink(),
        ),
      );
    }
    return Stepper(
      margin: EdgeInsets.zero,
      steps: children,
      onStepTapped: _changeCard,
      // physics: const NeverScrollableScrollPhysics(),
      controlsBuilder: (context, details) => const SizedBox.shrink(),
    );
  }

  Widget _directionCard() {
    return MotionAnimator().sharedAxisWidgetTransition(
      reverse: _previousIndex > _index,
      axis: SharedAxis.y,
      child: ListView(
        key: ValueKey(_index),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          Text(
            widget.receipe.directions[_index],
            style: const TextStyle(fontSize: 18, height: 1.5),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _actionButton() {
    return MotionAnimator().fadeThroughWidgetTransition(
      reverse: !_showDirections,
      child: TextButton(
        key: ValueKey(_showDirections),
        onPressed: () => setState(() => _showDirections = !_showDirections),
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_showDirections) const Icon(Icons.arrow_back, color: Colors.white),
            if (_showDirections) const SizedBox(width: 8),
            Text(
              _showDirections ? 'Ingredients' : 'Directions',
              style: const TextStyle(color: Colors.white),
            ),
            if (!_showDirections) const SizedBox(width: 8),
            if (!_showDirections) const Icon(Icons.arrow_forward, color: Colors.white),
          ],
        ),
      ),
    );
  }

  void _changeCard(int index) {
    _previousIndex = _index;
    setState(() => _index = index);
  }
}
