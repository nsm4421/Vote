import 'package:flutter/widgets.dart';

class Gap extends StatelessWidget {
  const Gap(this.size, {super.key});

  final double size;

  const Gap.h(this.size, {super.key});
  const Gap.v(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size, width: size);
  }
}
