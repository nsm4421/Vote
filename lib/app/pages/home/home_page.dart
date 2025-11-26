import 'package:app_component/components.dart';
import 'package:flutter/material.dart';
import 'package:vote/core/extension/build_context_extension.dart';

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
