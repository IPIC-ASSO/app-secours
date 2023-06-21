import 'package:flutter/material.dart';

class Chargement extends StatelessWidget {
  Chargement({super.key, required this.controller})
      :

  // Each animation defined here transforms its value during the subset
  // of the controller's duration defined by the animation's interval.
  // For example the opacity animation transforms its value during
  // the first 10% of the controller's duration.


        width1 = Tween<double>(
          begin: 0.0,
          end: 150.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.05,
              0.3,
              curve: Curves.ease,
            ),
          ),
        ),

        width2 = Tween<double>(
          begin: 0.0,
          end: 150.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.3,
              0.5,
              curve: Curves.ease,
            ),
          ),
        ),

        width3 = Tween<double>(
          begin: 0.0,
          end: 150.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.5,
              0.7,
              curve: Curves.ease,
            ),
          ),
        );

  final Animation<double> controller;
  final Animation<double> width1;
  final Animation<double> width2;
  final Animation<double> width3;
  // This function is called each time the controller "ticks" a new frame.
  // When it runs, all of the animation's values will have been
  // updated to reflect the controller's current value.
  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset("assets/charge_1.png", width: width1.value,alignment: Alignment.centerLeft,),
        Image.asset("assets/charge_3.png", width: width3.value,alignment: Alignment.centerLeft,),
        Image.asset("assets/charge_2.png", width: width2.value,alignment: Alignment.centerLeft,),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
