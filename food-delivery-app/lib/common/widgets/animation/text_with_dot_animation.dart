import 'package:flutter/material.dart';

class TextWithDotAnimation extends StatelessWidget {
  final String? text;
  final bool center;
  final int interval;
  final TextStyle? textStyle;

  const TextWithDotAnimation({
    this.text = "Waiting",
    this.center = false,
    this.interval = 8,
    this.textStyle,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _dotStream(),
      builder: (context, snapshot) {
        final dotCount = snapshot.data ?? 0;
        final dots = List.generate(dotCount, (_) => '.').join();
        return Text(
          '${text}${dots}',
          textAlign: (center) ? TextAlign.center : TextAlign.start,
          style: textStyle ?? TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        );
      },
    );
  }

  Stream<int> _dotStream() async* {
    int dotCount = 0;
    while (true) {
      yield dotCount;
      dotCount = (dotCount + 1) % interval;
      await Future.delayed(Duration(milliseconds: 500));
    }
  }
}
