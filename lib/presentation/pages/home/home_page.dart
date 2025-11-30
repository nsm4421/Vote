import 'package:app_extension/app_extension.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: context.l10n.homeTitle,
      child: Center(child: Text(context.l10n.homeBodyPlaceholder)),
    );
  }
}
