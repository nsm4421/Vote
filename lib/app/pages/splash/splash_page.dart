import 'package:app_component/components.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:vote/core/extension/build_context_extension.dart';
import 'package:vote/core/extension/color_extension.dart';

import '../../router/app_router.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.colorScheme.primary.withOpacityClamped(0.95),
              context.colorScheme.secondary.withOpacityClamped(0.9),
              context.colorScheme.surface,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            const _GlowCircle(
              size: 220,
              color: Colors.white,
              offset: Offset(-40, -60),
              opacity: 0.18,
            ),
            _GlowCircle(
              size: 180,
              color: context.colorScheme.tertiary,
              offset: const Offset(220, 120),
              opacity: 0.25,
            ),
            _GlowCircle(
              size: 280,
              color: context.colorScheme.primary,
              offset: const Offset(-120, 380),
              opacity: 0.22,
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight - 40,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _Tag(
                              color: context.colorScheme.onPrimary
                                  .withOpacityClamped(0.2),
                              textColor: context.colorScheme.onPrimary,
                              label: context.l10n.splashTagRealtime,
                            ),
                            const Gap(20),
                            Text(
                              context.l10n.splashHeadline,
                              style: context.textTheme.displaySmall?.copyWith(
                                color: context.colorScheme.onPrimary,
                                height: 1.1,
                              ),
                            ),
                            const Gap(12),
                            Text(
                              context.l10n.splashDescription,
                              style: context.textTheme.bodyLarge?.copyWith(
                                color: context.colorScheme.onPrimary
                                    .withOpacityClamped(0.9),
                                height: 1.4,
                              ),
                            ),
                            const Gap(36),
                            AppCard(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _FeatureRow(
                                    icon: Icons.flash_on_rounded,
                                    title:
                                        context.l10n.splashFeatureInstantTitle,
                                    description:
                                        context.l10n.splashFeatureInstantDesc,
                                    color: context.colorScheme.primary,
                                  ),
                                  const Gap(16),
                                  _FeatureRow(
                                    icon: Icons.shield_outlined,
                                    title: context.l10n.splashFeatureSafeTitle,
                                    description:
                                        context.l10n.splashFeatureSafeDesc,
                                    color: context.colorScheme.secondary,
                                  ),
                                  const Gap(16),
                                  _FeatureRow(
                                    icon: Icons.show_chart_rounded,
                                    title:
                                        context.l10n.splashFeatureRealtimeTitle,
                                    description:
                                        context.l10n.splashFeatureRealtimeDesc,
                                    color: context.colorScheme.tertiary,
                                  ),
                                ],
                              ),
                            ),
                            const Gap(28),
                            PrimaryButton(
                              label: context.l10n.splashStartCta,
                              icon: Icons.arrow_forward_rounded,
                              onPressed: () => context.go(AppRoutes.home.path),
                            ),
                            const Gap(10),
                            Text(
                              context.l10n.splashDemoInfo,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.onPrimary
                                    .withOpacityClamped(0.9),
                              ),
                            ),
                            const Gap(12),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({
    required this.size,
    required this.color,
    required this.offset,
    this.opacity = 0.25,
  });

  final double size;
  final Color color;
  final Offset offset;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final dimmed = color.withOpacityClamped(opacity);
    final glow = color.withOpacityClamped((opacity + 0.1).clamp(0.0, 1.0));
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: dimmed,
          boxShadow: [
            BoxShadow(
              color: glow,
              blurRadius: size * 0.35,
              spreadRadius: size * 0.15,
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final bodyColor = context.textTheme.bodyMedium?.color ?? Colors.black;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacityClamped(0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: color),
        ),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: context.textTheme.titleMedium),
              const Gap(6),
              Text(
                description,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: bodyColor.withOpacityClamped(0.85),
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({
    required this.color,
    required this.textColor,
    required this.label,
  });

  final Color color;
  final Color textColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    final outline = textColor.withOpacityClamped(0.3);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: outline),
      ),
      child: Text(
        label.toUpperCase(),
        style: context.textTheme.labelLarge?.copyWith(
          color: textColor,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}
