import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orderman_flutter/shared/widgets/phoenix_status_header.dart';

class PhoenixPageScaffold extends ConsumerWidget {
  const PhoenixPageScaffold({
    super.key,
    required this.title,
    this.subtitle,
    this.headerActions = const <Widget>[],
    required this.body,
    this.floatingActionButton,
  });

  final String title;
  final String? subtitle;
  final List<Widget> headerActions;
  final Widget body;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context);
    final viewPadding = mediaQuery.viewPadding;
    final isLandscape = mediaQuery.size.width > mediaQuery.size.height;
    final horizontalPadding = isLandscape ? 32.0 : 24.0;
    final bottomInset = viewPadding.bottom + 20;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      floatingActionButton: floatingActionButton,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            PhoenixStatusHeader(
              title: title,
              subtitle: subtitle,
              actions: headerActions,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding + viewPadding.left,
                  0,
                  horizontalPadding + viewPadding.right,
                  bottomInset,
                ),
                child: body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
