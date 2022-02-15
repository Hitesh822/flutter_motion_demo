import 'package:flutter/material.dart';
import 'package:flutter_motion_demo/models/receipe_model.dart';
import 'package:flutter_motion_demo/routers/motion_animator.dart';
import 'package:flutter_motion_demo/screens/receipe_details_screen.dart';

class RecipesView extends StatelessWidget {
  const RecipesView({Key? key, required this.receipes}) : super(key: key);
  final List<ReceipeModel> receipes;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      itemCount: receipes.length,
      itemBuilder: (context, index) => MotionAnimator().containerTransformTransition(
        closedBuilder: (context, openContainer) => _listItem(context, receipes[index], openContainer),
        openBuilder: (context, closeContainer) => ReceipeDetailsScreen(receipe: receipes[index]),
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }

  Widget _listItem(BuildContext context, ReceipeModel receipe, VoidCallback openContainer) {
    return ListTile(
      onTap: () => openContainer(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      leading: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: Image.network(receipe.image, fit: BoxFit.cover),
        ),
      ),
      title: Text(
        receipe.name,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        receipe.author,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
