import 'package:flutter/material.dart';

class TrainLoading extends StatefulWidget {
  const TrainLoading({super.key});

  @override
  State<TrainLoading> createState() => _TrainLoadingState();
}

class _TrainLoadingState extends State<TrainLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _animation = Tween<double>(
      begin: -1,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // الخط (السكة)
          Container(
            height: 4,
            width: double.infinity,
            color: Colors.grey.shade400,
          ),

          // القطار
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Align(
                alignment: Alignment(_animation.value, 0),
                child: const Icon(Icons.train, size: 40, color: Colors.blue),
              );
            },
          ),
        ],
      ),
    );
  }
}
