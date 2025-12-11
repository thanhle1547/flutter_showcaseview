/*
 * Copyright (c) 2021 Simform Solutions
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import 'package:flutter/material.dart';

import '../enum.dart';
import '../showcase_widget.dart';
import '../tooltip_widget.dart';
import 'showcase_controller.dart';

class Showcase extends StatefulWidget {
  /// A key that is unique across the entire app.
  ///
  /// This Key will be used to control state of individual showcase and also
  /// used in [ShowCaseWidgetState.startShowCase] to define position of current
  /// target widget while showcasing.
  final GlobalKey showcaseKey;

  /// Target widget that will be showcased or highlighted
  final Widget child;

  /// Represents subject line of target widget
  final String? title;

  /// Represents summary description of target widget
  final String? description;

  /// ShapeBorder of the highlighted box when target widget will be showcased.
  ///
  /// Note: If [targetBorderRadius] is specified, this parameter will be ignored.
  ///
  /// Default value is:
  /// ```dart
  /// RoundedRectangleBorder(
  ///   borderRadius: BorderRadius.all(Radius.circular(8)),
  /// ),
  /// ```
  final ShapeBorder targetShapeBorder;

  /// Radius of rectangle box while target widget is being showcased.
  ///
  /// Default value is:
  /// ```dart
  /// const Radius.circular(3.0),
  /// ```
  final BorderRadius? targetBorderRadius;

  /// TextStyle for default tooltip title
  final TextStyle? titleTextStyle;

  /// TextStyle for default tooltip description
  final TextStyle? descTextStyle;

  /// Empty space around tooltip content.
  ///
  /// Default Value for [Showcase] widget is:
  /// ```dart
  /// EdgeInsets.symmetric(vertical: 8, horizontal: 8)
  /// ```
  final EdgeInsets tooltipPadding;

  final EdgeInsets alignedFromParent;

  /// Background color of overlay during showcase.
  ///
  /// Default value is [Colors.black45]
  final Color overlayColor;

  /// Opacity apply on [overlayColor] (which ranges from 0.0 to 1.0)
  ///
  /// Default to 0.75
  final double overlayOpacity;

  /// Custom tooltip widget when [Showcase.withWidget] is used.
  final Widget? container;

  /// The widget to show over the top of the overlay and tooltip.
  ///
  /// Typically a [Positioned] widget.
  ///
  /// It can be a button to dismiss the showcase.
  final Widget? floatingActionWidget;

  /// Defines background color for tooltip widget.
  ///
  /// Default to [Colors.white]
  final Color tooltipBackgroundColor;

  /// Defines text color of default tooltip when [titleTextStyle] and
  /// [descTextStyle] is not provided.
  ///
  /// Default to [Colors.black]
  final Color textColor;

  /// If [enableAutoScroll] is sets to `true`, this widget will be shown above
  /// the overlay until the target widget is visible in the viewport.
  final Widget scrollLoadingWidget;

  /// Whether the default tooltip will have arrow to point out the target widget.
  ///
  /// Default to `true`
  final bool showArrow;

  final EdgeInsets arrowVerticalMargin;

  /// Custom arrow painter
  final ArrowPainterBuilder? arrowPainterBuilder;

  /// Height of [container]
  final double? height;

  /// Width of [container]
  final double? width;

  /// The duration of time the bouncing animation of tooltip should last.
  ///
  /// Default to [Duration(milliseconds: 2000)]
  final Duration movingAnimationDuration;

  /// Triggered when default tooltip is tapped
  final VoidCallback? onTooltipClick;

  /// Triggered when showcased target widget is tapped
  ///
  /// Note: [disposeOnTap] is required if you're using [onTargetClick]
  /// otherwise throws error
  final VoidCallback? onTargetClick;

  /// Will dispose all showcases if tapped on target widget or tooltip
  ///
  /// Note: [onTargetClick] is required if you're using [disposeOnTap]
  /// otherwise throws error
  final bool? disposeOnTap;

  /// Whether tooltip should have bouncing animation while showcasing
  ///
  /// If null value is provided,
  /// [ShowCaseWidget.disableAnimation] will be considered.
  final bool? disableMovingAnimation;

  /// Whether disabling initial scale animation for default tooltip when
  /// showcase is started and completed
  ///
  /// Default to `false`
  final bool? disableScaleAnimation;

  /// Custom the bounding box of the overlay that gets clipped
  final GlobalKey? visibleBoundReference;

  /// Padding around target widget
  ///
  /// Default to [EdgeInsets.zero]
  final EdgeInsets targetPadding;

  /// Triggered when target has been double tapped
  final VoidCallback? onTargetDoubleTap;

  /// Triggered when target has been long pressed.
  ///
  /// Detected when a pointer has remained in contact with the screen at the same location for a long period of time.
  final VoidCallback? onTargetLongPress;

  /// Border Radius of default tooltip
  ///
  /// Default to [BorderRadius.circular(8)]
  final BorderRadius? tooltipBorderRadius;

  /// if `disableDefaultTargetGestures` parameter is true
  /// onTargetClick, onTargetDoubleTap, onTargetLongPress and
  /// disposeOnTap parameter will not work
  ///
  /// Note: If `disableDefaultTargetGestures` is true then make sure to
  /// dismiss current showcase with `ShowCaseWidget.of(context).dismiss()`
  /// if you are navigating to other screen. This will be handled by default
  /// if `disableDefaultTargetGestures` is set to false.
  final bool disableDefaultTargetGestures;

  /// Defines blur value.
  /// This will blur the background while displaying showcase.
  ///
  /// If null value is provided,
  /// [ShowCaseWidget.blurValue] will be considered.
  ///
  final double? blurValue;

  /// A duration for animation which is going to played when
  /// tooltip comes first time in the view.
  ///
  /// Defaults to 300 ms.
  final Duration scaleAnimationDuration;

  /// The curve to be used for initial animation of tooltip.
  ///
  /// Defaults to Curves.easeIn
  final Curve scaleAnimationCurve;

  /// An alignment to origin of initial tooltip animation.
  ///
  /// Alignment will be pre-calculated but if pre-calculated
  /// alignment doesn't work then this parameter can be
  /// used to customise the direction of the tooltip animation.
  ///
  /// eg.
  /// ```dart
  ///     Alignment(-0.2,0.3) or Alignment.centerLeft
  /// ```
  final Alignment? scaleAnimationAlignment;

  /// Defines vertical position of tooltip respective to Target widget
  ///
  /// Defaults to adaptive into available space.
  final TooltipPosition? tooltipPosition;

  /// Provides padding around the title. Default padding is zero.
  final EdgeInsets? titlePadding;

  /// Provides padding around the description. Default padding is zero.
  final EdgeInsets? descriptionPadding;

  /// Provides text direction of tooltip title.
  final TextDirection? titleTextDirection;

  /// Provides text direction of tooltip description.
  final TextDirection? descriptionTextDirection;

  /// Provides a callback when barrier has been clicked.
  ///
  /// Note-: Even if barrier interactions are disabled, this handler
  /// will still provide a callback.
  final VoidCallback? onBarrierClick;

  /// For disabling barrier interaction for a particular showCase
  final bool disableBarrierInteraction;

  /// Title widget alignment within tooltip widget
  ///
  /// Defaults to [Alignment.center]
  final AlignmentGeometry titleAlignment;

  /// Title text alignment with in tooltip widget
  ///
  /// Defaults to [TextAlign.start]
  /// To understand how text is aligned, check [TextAlign]
  final TextAlign titleTextAlign;

  /// Description widget alignment within tooltip widget
  ///
  /// Defaults to [Alignment.center]
  final AlignmentGeometry descriptionAlignment;

  /// Description text alignment with in tooltip widget
  ///
  /// Defaults to [TextAlign.start]
  /// To understand how text is aligned, check [TextAlign]
  final TextAlign descriptionTextAlign;

  /// This keys will be used to show multiple showcase widget.
  /// Note: When child showcase are visible their [onBarrierClick] click will
  /// not work as there will be only parent barrier.
  ///
  /// Defaults to <GlobalKey>[].
  final List<GlobalKey> linkedShowcaseKeys;

  const Showcase({
    required GlobalKey key,
    required this.description,
    required this.child,
    this.title,
    this.titleTextAlign = TextAlign.start,
    this.descriptionTextAlign = TextAlign.start,
    this.titleAlignment = Alignment.center,
    this.descriptionAlignment = Alignment.center,
    this.targetShapeBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    this.overlayColor = Colors.black45,
    this.overlayOpacity = 0.75,
    this.titleTextStyle,
    this.descTextStyle,
    this.tooltipBackgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.scrollLoadingWidget = const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.white),
    ),
    this.showArrow = true,
    EdgeInsets? arrowVerticalMargin,
    this.arrowPainterBuilder,
    this.floatingActionWidget,
    this.onTargetClick,
    this.disposeOnTap,
    this.movingAnimationDuration = const Duration(milliseconds: 2000),
    this.disableMovingAnimation,
    this.disableScaleAnimation,
    this.alignedFromParent = const EdgeInsets.symmetric(horizontal: 14),
    this.tooltipPadding = const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    this.onTooltipClick,
    this.visibleBoundReference,
    this.targetPadding = EdgeInsets.zero,
    this.blurValue,
    this.targetBorderRadius,
    this.onTargetLongPress,
    this.onTargetDoubleTap,
    this.tooltipBorderRadius,
    this.disableDefaultTargetGestures = false,
    this.scaleAnimationDuration = const Duration(milliseconds: 300),
    this.scaleAnimationCurve = Curves.easeIn,
    this.scaleAnimationAlignment,
    this.tooltipPosition,
    this.titlePadding,
    this.descriptionPadding,
    this.titleTextDirection,
    this.descriptionTextDirection,
    this.onBarrierClick,
    this.disableBarrierInteraction = false,
    this.linkedShowcaseKeys = const <GlobalKey>[],
  })  : height = null,
        width = null,
        container = null,
        showcaseKey = key,
        arrowVerticalMargin = !showArrow
            ? EdgeInsets.zero
            : arrowVerticalMargin ??
                (showArrow ? const EdgeInsets.only(top: 22, bottom: 27) : const EdgeInsets.symmetric(vertical: 10)),
        assert(overlayOpacity >= 0.0 && overlayOpacity <= 1.0, "overlay opacity must be between 0 and 1."),
        assert(onTargetClick == null || disposeOnTap != null, "disposeOnTap is required if you're using onTargetClick"),
        assert(disposeOnTap == null || onTargetClick != null, "onTargetClick is required if you're using disposeOnTap"),
        assert(onBarrierClick == null || disableBarrierInteraction == false, "can't use onBarrierClick & disableBarrierInteraction property at same time");

  const Showcase.withWidget({
    required GlobalKey key,
    required this.height,
    required this.width,
    required this.container,
    this.floatingActionWidget,
    this.alignedFromParent = const EdgeInsets.only(
      left: 16,
      right: 8,
      top: 10,
      bottom: 10,
    ),
    required this.child,
    this.arrowVerticalMargin = const EdgeInsets.symmetric(vertical: 10),
    this.arrowPainterBuilder,
    this.targetShapeBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    this.overlayColor = Colors.black45,
    this.targetBorderRadius,
    this.overlayOpacity = 0.75,
    this.scrollLoadingWidget = const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white)),
    this.onTargetClick,
    this.disposeOnTap,
    this.movingAnimationDuration = const Duration(milliseconds: 2000),
    this.disableMovingAnimation,
    this.visibleBoundReference,
    this.targetPadding = EdgeInsets.zero,
    this.blurValue,
    this.onTargetLongPress,
    this.onTargetDoubleTap,
    this.disableDefaultTargetGestures = false,
    this.tooltipPosition,
    this.onBarrierClick,
    this.disableBarrierInteraction = false,
    this.linkedShowcaseKeys = const <GlobalKey>[],
  })  : showArrow = arrowPainterBuilder != null,
        onTooltipClick = null,
        scaleAnimationDuration = const Duration(milliseconds: 300),
        scaleAnimationCurve = Curves.decelerate,
        scaleAnimationAlignment = null,
        disableScaleAnimation = null,
        title = null,
        description = null,
        titleTextAlign = TextAlign.start,
        descriptionTextAlign = TextAlign.start,
        titleAlignment = Alignment.center,
        descriptionAlignment = Alignment.center,
        titleTextStyle = null,
        descTextStyle = null,
        tooltipBackgroundColor = Colors.white,
        textColor = Colors.black,
        tooltipBorderRadius = null,
        tooltipPadding = const EdgeInsets.symmetric(vertical: 8),
        titlePadding = null,
        descriptionPadding = null,
        titleTextDirection = null,
        descriptionTextDirection = null,
        showcaseKey = key,
        assert(overlayOpacity >= 0.0 && overlayOpacity <= 1.0, "overlay opacity must be between 0 and 1."),
        assert(onBarrierClick == null || disableBarrierInteraction == false, "can't use onBarrierClick & disableBarrierInteraction property at same time");

  @override
  State<Showcase> createState() => _ShowcaseState();
}

class _ShowcaseState extends State<Showcase> with WidgetsBindingObserver {
  ShowcaseController get _controller =>
      _showCaseWidgetState.getControllerForShowcase(
        key: widget.showcaseKey,
        showcaseId: _uniqueId,
      );

  late var _showCaseWidgetState = ShowCaseWidget.of(context);

  final int _uniqueId = UniqueKey().hashCode;

  ShowCaseWidgetState get showCaseWidgetState => ShowCaseWidget.of(context);

  @override
  void initState() {
    super.initState();
    ShowcaseController(
      id: _uniqueId,
      key: widget.showcaseKey,
      containerKey: widget.visibleBoundReference,
      showcaseState: this,
      showCaseWidgetState: ShowCaseWidget.of(context),
    );
  }

  @override
  void didUpdateWidget(covariant Showcase oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget == widget) return;
    _updateControllerValues();
  }

  _updateControllerValues() {
    _showCaseWidgetState = ShowCaseWidget.of(context);
    _controller
      ..showcaseState = this
      ..showCaseWidgetState = _showCaseWidgetState;
  }

  @override
  Widget build(BuildContext context) {
    // This is to support hot reload
    _updateControllerValues();

    _controller.recalculateRootWidgetSize(context);
    return widget.child;
  }

  @override
  void dispose() {
    _showCaseWidgetState.removeShowcaseController(
      key: widget.showcaseKey,
      uniqueShowcaseKey: _uniqueId,
    );
    super.dispose();
  }
}
