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

import 'dart:math';

import 'package:flutter/material.dart';

import 'arrow_painter.dart';
import 'enum.dart';
import 'get_position.dart';
import 'measure_size.dart';

const _kDefaultToolTipHeight = 120.0;
const EdgeInsets _kDefaultDescriptionPadding = EdgeInsets.zero;

typedef ArrowPainterBuilder = ArrowPainter Function(bool isArrowUp);

abstract class ToolTipBaseWidget extends StatefulWidget {
  final GetPosition? position;
  final Offset offset;
  final Size screenSize;
  final bool showArrow;
  final EdgeInsets arrowVerticalMargin;
  final ArrowPainterBuilder? arrowPainterBuilder;
  final VoidCallback? onTooltipTap;
  final Duration movingAnimationDuration;
  final bool disableMovingAnimation;
  final bool disableScaleAnimation;
  final Duration scaleAnimationDuration;
  final Curve scaleAnimationCurve;
  final bool isTooltipDismissed;
  final EdgeInsets horizontalPaddingFromParent;
  final TooltipPosition? tooltipPosition;

  const ToolTipBaseWidget._({
    Key? key,
    this.position,
    required this.offset,
    required this.screenSize,
    required this.showArrow,
    required this.arrowVerticalMargin,
    this.arrowPainterBuilder,
    this.onTooltipTap,
    required this.movingAnimationDuration,
    required this.disableMovingAnimation,
    required this.disableScaleAnimation,
    required this.scaleAnimationDuration,
    required this.scaleAnimationCurve,
    this.isTooltipDismissed = false,
    required this.horizontalPaddingFromParent,
    this.tooltipPosition,
  }) : super(key: key);

  const factory ToolTipBaseWidget({
    GetPosition? position,
    required Offset offset,
    required Size screenSize,
    String? title,
    TextAlign? titleAlignment,
    required String description,
    TextAlign? descriptionAlignment,
    TextStyle? titleTextStyle,
    TextStyle? descTextStyle,
    Color? tooltipBackgroundColor,
    Color? textColor,
    required EdgeInsets horizontalPaddingFromParent,
    EdgeInsets? tooltipPadding,
    BorderRadius? tooltipBorderRadius,
    required bool showArrow,
    required EdgeInsets arrowVerticalMargin,
    ArrowPainterBuilder? arrowPainterBuilder,
    VoidCallback? onTooltipTap,
    required Duration movingAnimationDuration,
    required bool disableMovingAnimation,
    required bool disableScaleAnimation,
    required Duration scaleAnimationDuration,
    required Curve scaleAnimationCurve,
    Alignment? scaleAnimationAlignment,
    bool isTooltipDismissed,
    TooltipPosition? tooltipPosition,
    EdgeInsets? titlePadding,
    required EdgeInsets descriptionPadding,
    TextDirection? titleTextDirection,
    TextDirection? descriptionTextDirection,
  }) = _DefaultToolTipWidget;

  factory ToolTipBaseWidget.resolve({
    GetPosition? position,
    required Offset offset,
    required Size screenSize,
    String? title,
    TextAlign? titleAlignment,
    String? description,
    TextAlign? descriptionAlignment,
    TextStyle? titleTextStyle,
    TextStyle? descTextStyle,
    Color? tooltipBackgroundColor,
    Color? textColor,
    required bool showArrow,
    required EdgeInsets arrowVerticalMargin,
    ArrowPainterBuilder? arrowPainterBuilder,
    Widget? container,
    double? contentHeight,
    double? contentWidth,
    required EdgeInsets horizontalPaddingFromParent,
    EdgeInsets? tooltipPadding,
    BorderRadius? tooltipBorderRadius,
    VoidCallback? onTooltipTap,
    required Duration movingAnimationDuration,
    required bool disableMovingAnimation,
    required bool disableScaleAnimation,
    required Duration scaleAnimationDuration,
    required Curve scaleAnimationCurve,
    Alignment? scaleAnimationAlignment,
    required bool isTooltipDismissed,
    TooltipPosition? tooltipPosition,
    EdgeInsets? titlePadding,
    EdgeInsets? descriptionPadding,
    TextDirection? titleTextDirection,
    TextDirection? descriptionTextDirection,
  }) {
    if (container != null) {
      assert(contentWidth != null);

      return _CustomToolTipWidget(
        position: position,
        offset: offset,
        screenSize: screenSize,
        showArrow: showArrow,
        arrowVerticalMargin: arrowVerticalMargin,
        arrowPainterBuilder: arrowPainterBuilder,
        container: container,
        horizontalPaddingFromParent: horizontalPaddingFromParent,
        contentHeight: contentHeight ?? _kDefaultToolTipHeight,
        contentWidth: contentWidth!,
        onTooltipTap: onTooltipTap,
        movingAnimationDuration: movingAnimationDuration,
        disableMovingAnimation: disableMovingAnimation,
        disableScaleAnimation: disableScaleAnimation,
        scaleAnimationDuration: scaleAnimationDuration,
        scaleAnimationCurve: scaleAnimationCurve,
        isTooltipDismissed: isTooltipDismissed,
        tooltipPosition: tooltipPosition,
      );
    }

    assert(description != null);

    return _DefaultToolTipWidget(
      position: position,
      offset: offset,
      screenSize: screenSize,
      title: title,
      titleAlignment: titleAlignment,
      description: description!,
      descriptionAlignment: descriptionAlignment,
      titleTextStyle: titleTextStyle,
      descTextStyle: descTextStyle,
      tooltipBackgroundColor: tooltipBackgroundColor,
      textColor: textColor,
      horizontalPaddingFromParent: horizontalPaddingFromParent,
      tooltipPadding: tooltipPadding,
      tooltipBorderRadius: tooltipBorderRadius,
      showArrow: showArrow,
      arrowVerticalMargin: arrowVerticalMargin,
      arrowPainterBuilder: arrowPainterBuilder,
      onTooltipTap: onTooltipTap,
      movingAnimationDuration: movingAnimationDuration,
      disableMovingAnimation: disableMovingAnimation,
      disableScaleAnimation: disableScaleAnimation,
      scaleAnimationDuration: scaleAnimationDuration,
      scaleAnimationCurve: scaleAnimationCurve,
      scaleAnimationAlignment: scaleAnimationAlignment,
      isTooltipDismissed: isTooltipDismissed,
      tooltipPosition: tooltipPosition,
      titlePadding: titlePadding,
      descriptionPadding: descriptionPadding ?? _kDefaultDescriptionPadding,
      titleTextDirection: titleTextDirection,
      descriptionTextDirection: descriptionTextDirection,
    );
  }

  const factory ToolTipBaseWidget.custom({
    GetPosition? position,
    required Offset offset,
    required Size screenSize,
    required bool showArrow,
    required EdgeInsets arrowVerticalMargin,
    ArrowPainterBuilder? arrowPainterBuilder,
    required EdgeInsets horizontalPaddingFromParent,
    required Widget container,
    double contentHeight,
    required double contentWidth,
    VoidCallback? onTooltipTap,
    required Duration movingAnimationDuration,
    required bool disableMovingAnimation,
    required bool disableScaleAnimation,
    required Duration scaleAnimationDuration,
    required Curve scaleAnimationCurve,
    bool isTooltipDismissed,
    TooltipPosition? tooltipPosition,
  }) = _CustomToolTipWidget;

  @override
  State<ToolTipBaseWidget> createState();
}

mixin _ToolTipMixin<T extends ToolTipBaseWidget> on State<T>, TickerProviderStateMixin<T> {
  late final AnimationController _movingAnimationController;
  late final Animation<double> _movingAnimation;
  late final AnimationController _scaleAnimationController;
  late final Animation<double> _scaleAnimation;

  Offset? position;

  bool isArrowUp = false;

  late double paddingTop;
  late double paddingBottom;
  late double contentY;
  late double contentFractionalOffset;

  void _updateNumeral() {
    position = widget.offset;
    final contentOrientation = widget.tooltipPosition ?? findPositionForContent(position!);
    final contentOffsetMultiplier = contentOrientation == TooltipPosition.bottom ? 1.0 : -1.0;
    isArrowUp = contentOffsetMultiplier == 1.0;

    contentY = isArrowUp
        ? widget.position!.getBottom() + (contentOffsetMultiplier * 3)
        : widget.position!.getTop() + (contentOffsetMultiplier * 3);

    contentFractionalOffset = contentOffsetMultiplier.clamp(-1.0, 0.0);

    if (!widget.showArrow) {
      paddingTop = widget.arrowVerticalMargin.top;
      paddingBottom = widget.arrowVerticalMargin.bottom;
    } else {
      paddingTop = isArrowUp ? widget.arrowVerticalMargin.top : 0.0;
      paddingBottom = isArrowUp ? 0.0 : widget.arrowVerticalMargin.bottom;
    }
  }

  double get toolTipHeight => _kDefaultToolTipHeight;

  TooltipPosition findPositionForContent(Offset position) {
    final height = toolTipHeight;

    final positionHeight = widget.position?.getHeight() ?? 0;
    final calculatedPositionHeight = positionHeight / 2;

    final bottomPosition = position.dy + calculatedPositionHeight;
    final topPosition = position.dy - calculatedPositionHeight;

    final hasSpaceInTop = topPosition >= height;

    final flutterView = View.of(context);
    final EdgeInsets viewInsets = EdgeInsets.fromViewPadding(flutterView.viewInsets, flutterView.devicePixelRatio);

    final double actualVisibleScreenHeight = widget.screenSize.height - viewInsets.bottom;
    final hasSpaceInBottom = (actualVisibleScreenHeight - bottomPosition) >= height;
    return (hasSpaceInTop && !hasSpaceInBottom ? TooltipPosition.top : TooltipPosition.bottom);
  }

  double get tooltipWidth;

  double? _getLeft() {
    if (widget.position != null) {
      final width = tooltipWidth;
      double leftPositionValue = widget.position!.getCenter() - (width * 0.5);
      if ((leftPositionValue + width) > widget.screenSize.width) {
        return null;
      } else if ((leftPositionValue) < widget.horizontalPaddingFromParent.left) {
        return widget.horizontalPaddingFromParent.left;
      } else {
        return leftPositionValue;
      }
    }
    return null;
  }

  double? _getRight() {
    if (widget.position != null) {
      final width = tooltipWidth;

      final left = _getLeft();
      if (left == null || (left + width) > widget.screenSize.width) {
        final rightPosition = widget.position!.getCenter() + (width * 0.5);

        return (rightPosition + width) > widget.screenSize.width ? widget.horizontalPaddingFromParent.right : null;
      } else {
        return null;
      }
    }
    return null;
  }

  double? _getArrowLeft(double arrowWidth) {
    double? left = _getLeft();
    if (left == null) return null;
    return (widget.position!.getCenter() - (arrowWidth / 2) - left);
  }

  double? _getArrowRight(double arrowWidth) {
    return (widget.screenSize.width - widget.position!.getCenter()) - (_getRight() ?? 0) - (arrowWidth / 2);
  }

  @override
  void initState() {
    super.initState();
    _movingAnimationController = AnimationController(
      duration: widget.movingAnimationDuration,
      vsync: this,
    );
    _movingAnimation = CurvedAnimation(
      parent: _movingAnimationController,
      curve: Curves.easeInOut,
    );
    _scaleAnimationController = AnimationController(
      duration: widget.scaleAnimationDuration,
      vsync: this,
      lowerBound: widget.disableScaleAnimation ? 1 : 0,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _scaleAnimationController,
      curve: widget.scaleAnimationCurve,
    );
    if (widget.disableScaleAnimation) {
      movingAnimationListener();
    } else {
      _scaleAnimationController
        ..addStatusListener(_scaleAnimationControllerStatusListener)
        ..forward();
    }
    if (!widget.disableMovingAnimation) {
      _movingAnimationController.forward();
    }
  }

  void movingAnimationListener() {
    _movingAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _movingAnimationController.reverse();
      }
      if (_movingAnimationController.isDismissed) {
        if (!widget.disableMovingAnimation) {
          _movingAnimationController.forward();
        }
      }
    });
  }

  void _scaleAnimationControllerStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      movingAnimationListener();
    }
  }

  @override
  void dispose() {
    _movingAnimationController.dispose();
    _scaleAnimationController.dispose();

    if (widget.disableScaleAnimation) {
      _scaleAnimationController.removeStatusListener(_scaleAnimationControllerStatusListener);
    }

    super.dispose();
  }

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    _updateNumeral();

    if (!widget.disableScaleAnimation && widget.isTooltipDismissed) {
      _scaleAnimationController.reverse();
    }

    return const _NullWidget();
  }
}

class _NullWidget extends StatelessWidget {
  const _NullWidget();

  @override
  Widget build(BuildContext context) {
    throw FlutterError(
      'Widgets that mix _ToolTipMixin into their State must '
      'call super.build() but must ignore the return value of the superclass.',
    );
  }
}

class _DefaultToolTipWidget extends ToolTipBaseWidget {
  const _DefaultToolTipWidget({
    GetPosition? position,
    required Offset offset,
    required Size screenSize,
    this.title,
    this.titleAlignment,
    required this.description,
    this.descriptionAlignment,
    this.titleTextStyle,
    this.descTextStyle,
    this.tooltipBackgroundColor,
    this.textColor,
    required EdgeInsets horizontalPaddingFromParent,
    this.tooltipPadding,
    this.tooltipBorderRadius,
    required bool showArrow,
    required EdgeInsets arrowVerticalMargin,
    ArrowPainterBuilder? arrowPainterBuilder,
    VoidCallback? onTooltipTap,
    required Duration movingAnimationDuration,
    required bool disableMovingAnimation,
    required bool disableScaleAnimation,
    required Duration scaleAnimationDuration,
    required Curve scaleAnimationCurve,
    this.scaleAnimationAlignment,
    bool isTooltipDismissed = false,
    TooltipPosition? tooltipPosition,
    this.titlePadding,
    this.descriptionPadding = _kDefaultDescriptionPadding,
    this.titleTextDirection,
    this.descriptionTextDirection,
  }) : super._(
          position: position,
          offset: offset,
          screenSize: screenSize,
          showArrow: showArrow,
          arrowVerticalMargin: arrowVerticalMargin,
          horizontalPaddingFromParent: horizontalPaddingFromParent,
          arrowPainterBuilder: arrowPainterBuilder,
          onTooltipTap: onTooltipTap,
          movingAnimationDuration: movingAnimationDuration,
          disableMovingAnimation: disableMovingAnimation,
          disableScaleAnimation: disableScaleAnimation,
          scaleAnimationDuration: scaleAnimationDuration,
          scaleAnimationCurve: scaleAnimationCurve,
          isTooltipDismissed: isTooltipDismissed,
          tooltipPosition: tooltipPosition,
        );

  final String? title;
  final TextAlign? titleAlignment;
  final String description;
  final TextAlign? descriptionAlignment;
  final TextStyle? titleTextStyle;
  final TextStyle? descTextStyle;

  final Color? tooltipBackgroundColor;
  final Color? textColor;

  final EdgeInsets? tooltipPadding;
  final BorderRadius? tooltipBorderRadius;

  final Alignment? scaleAnimationAlignment;
  final EdgeInsets? titlePadding;
  final EdgeInsets descriptionPadding;
  final TextDirection? titleTextDirection;
  final TextDirection? descriptionTextDirection;

  @override
  State<_DefaultToolTipWidget> createState() => __DefaultToolTipWidgetState();
}

class __DefaultToolTipWidgetState extends State<_DefaultToolTipWidget>
    with TickerProviderStateMixin<_DefaultToolTipWidget>, _ToolTipMixin<_DefaultToolTipWidget> {
  @override
  double tooltipWidth = 0;

  double tooltipScreenEdgePadding = 20;
  double tooltipTextPadding = 15;

  late TextTheme _textTheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _textTheme = Theme.of(context).textTheme;
    _getTooltipWidth();
  }

  @override
  void didUpdateWidget(_DefaultToolTipWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _getTooltipWidth();
  }

  void _getTooltipWidth() {
    final titleStyle = widget.titleTextStyle ?? _textTheme.titleLarge!.copyWith(color: widget.textColor);
    final descriptionStyle = widget.descTextStyle ?? _textTheme.titleSmall!.copyWith(color: widget.textColor);
    final titleLength = widget.title == null
        ? 0
        : _textSize(widget.title!, titleStyle).width +
            widget.tooltipPadding!.right +
            widget.tooltipPadding!.left +
            (widget.titlePadding?.right ?? 0) +
            (widget.titlePadding?.left ?? 0);
    final descriptionLength = _textSize(widget.description, descriptionStyle).width +
        widget.tooltipPadding!.right +
        widget.tooltipPadding!.left +
        widget.descriptionPadding.right +
        widget.descriptionPadding.left;
    final maxTextWidth = max(titleLength, descriptionLength);
    if (maxTextWidth > widget.screenSize.width - tooltipScreenEdgePadding) {
      tooltipWidth = widget.screenSize.width - tooltipScreenEdgePadding;
    } else {
      tooltipWidth = maxTextWidth + tooltipTextPadding;
    }
  }

  Size _textSize(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textScaleFactor: MediaQuery.textScaleFactorOf(context),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size;
  }

  double _getAlignmentX() {
    final calculatedLeft = _getLeft();
    final calculatedRight = _getRight() ?? 0;
    final calculatedCenter = widget.position!.getCenter();
    var left = calculatedLeft == null ? 0 : (calculatedCenter - calculatedLeft);
    var right = calculatedLeft == null ? (widget.screenSize.width - calculatedCenter) - calculatedRight : 0;
    final containerWidth = tooltipWidth;

    if (left != 0) {
      return (-1 + (2 * (left / containerWidth)));
    } else {
      return (1 - (2 * (right / containerWidth)));
    }
  }

  double _getAlignmentY() {
    var dy = isArrowUp
        ? -1.0
        : (MediaQuery.sizeOf(context).height / 2) < widget.position!.getTop()
            ? -1.0
            : 1.0;
    return dy;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    late final arrowPainter = widget.arrowPainterBuilder?.call(isArrowUp) ??
        ArrowPainter(
          strokeColor: widget.tooltipBackgroundColor!,
          strokeWidth: 10,
          paintingStyle: PaintingStyle.fill,
          isUpArrow: isArrowUp,
        );

    final left = _getLeft();

    final arrowLeftPosition = _getArrowLeft(arrowPainter.width);
    final arrowRightPosition = arrowLeftPosition != null ? null : _getArrowRight(arrowPainter.width);

    Widget current = Stack(
      clipBehavior: Clip.none,
      alignment: isArrowUp
          ? Alignment.topLeft
          : left == null
              ? Alignment.bottomRight
              : Alignment.bottomLeft,
      children: [
        if (widget.showArrow)
          Positioned(
            left: arrowLeftPosition,
            right: arrowRightPosition,
            child: CustomPaint(
              painter: arrowPainter,
              child: SizedBox(
                height: arrowPainter.height,
                width: arrowPainter.width,
              ),
            ),
          ),
        Padding(
          padding: EdgeInsets.only(
            top: isArrowUp ? arrowPainter.height - 1 : 0,
            bottom: isArrowUp ? 0 : arrowPainter.height - 1,
          ),
          child: ClipRRect(
            borderRadius: widget.tooltipBorderRadius ?? BorderRadius.circular(8.0),
            child: GestureDetector(
              onTap: widget.onTooltipTap,
              child: Container(
                width: tooltipWidth,
                padding: widget.tooltipPadding,
                color: widget.tooltipBackgroundColor,
                child: Column(
                  crossAxisAlignment: widget.title != null ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                  children: <Widget>[
                    if (widget.title != null)
                      Padding(
                        padding: widget.titlePadding ?? EdgeInsets.zero,
                        child: Text(
                          widget.title!,
                          textAlign: widget.titleAlignment,
                          textDirection: widget.titleTextDirection,
                          style: widget.titleTextStyle ??
                              _textTheme.titleLarge!.copyWith(
                                color: widget.textColor,
                              ),
                        ),
                      ),
                    Padding(
                      padding: widget.descriptionPadding,
                      child: Text(
                        widget.description,
                        textAlign: widget.descriptionAlignment,
                        textDirection: widget.descriptionTextDirection,
                        style: widget.descTextStyle ??
                            _textTheme.titleSmall!.copyWith(
                              color: widget.textColor,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );

    if (widget.showArrow) {
      // The height of the arrow when it is in the up direction
      final double upDelta = isArrowUp ? arrowPainter.height : 0;
      double paddingTop = this.paddingTop - upDelta;

      assert(
        paddingTop.isNegative == false,
        "arrowVerticalMargin(top: $paddingTop) which is less than "
        "${isArrowUp ? 'arrow(height: $upDelta)' : 0}. "
        "In release mode, paddingTop will be $upDelta",
      );
      if (paddingTop.isNegative) {
        paddingTop = upDelta;
      }

      // The height of the arrow when it is in the down direction
      final double bottomDelta = isArrowUp ? 0 : arrowPainter.height;
      double paddingBottom = this.paddingBottom - bottomDelta;

      assert(
        paddingBottom.isNegative == false,
        "arrowVerticalMargin(bottom: $paddingBottom) which is less than "
        "${isArrowUp ? 0 : 'the arrow(height: $bottomDelta)'}. "
        "In release mode, paddingBottom will be $bottomDelta",
      );
      if (paddingBottom.isNegative) {
        paddingBottom = bottomDelta;
      }

      current = Padding(
        padding: EdgeInsets.only(
          top: paddingTop,
          bottom: paddingBottom,
        ),
        child: current,
      );
    }

    return Positioned(
      top: contentY,
      left: left,
      right: _getRight(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        alignment: widget.scaleAnimationAlignment ??
            Alignment(
              _getAlignmentX(),
              _getAlignmentY(),
            ),
        child: FractionalTranslation(
          translation: Offset(0.0, contentFractionalOffset),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0.0, contentFractionalOffset / 10),
              end: const Offset(0.0, 0.100),
            ).animate(_movingAnimation),
            child: Material(
              type: MaterialType.transparency,
              child: current,
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomToolTipWidget extends ToolTipBaseWidget {
  const _CustomToolTipWidget({
    GetPosition? position,
    required Offset offset,
    required Size screenSize,
    required bool showArrow,
    required EdgeInsets arrowVerticalMargin,
    ArrowPainterBuilder? arrowPainterBuilder,
    EdgeInsets horizontalPaddingFromParent = const EdgeInsets.only(
      left: 16,
      right: 8,
      top: 10,
      bottom: 10,
    ),
    required this.container,
    this.contentHeight = _kDefaultToolTipHeight,
    required this.contentWidth,
    VoidCallback? onTooltipTap,
    required Duration movingAnimationDuration,
    required bool disableMovingAnimation,
    required bool disableScaleAnimation,
    required Duration scaleAnimationDuration,
    required Curve scaleAnimationCurve,
    bool isTooltipDismissed = false,
    TooltipPosition? tooltipPosition,
  }) : super._(
          position: position,
          offset: offset,
          screenSize: screenSize,
          showArrow: showArrow,
          arrowVerticalMargin: arrowVerticalMargin,
          arrowPainterBuilder: arrowPainterBuilder,
          horizontalPaddingFromParent: horizontalPaddingFromParent,
          onTooltipTap: onTooltipTap,
          movingAnimationDuration: movingAnimationDuration,
          disableMovingAnimation: disableMovingAnimation,
          disableScaleAnimation: disableScaleAnimation,
          scaleAnimationDuration: scaleAnimationDuration,
          scaleAnimationCurve: scaleAnimationCurve,
          isTooltipDismissed: isTooltipDismissed,
          tooltipPosition: tooltipPosition,
        );

  final Widget container;

  final double contentHeight;
  final double contentWidth;

  @override
  State<_CustomToolTipWidget> createState() => _CustomToolTipBaseWidgetState();
}

class _CustomToolTipBaseWidgetState extends State<_CustomToolTipWidget>
    with TickerProviderStateMixin<_CustomToolTipWidget>, _ToolTipMixin<_CustomToolTipWidget> {
  @override
  late double tooltipWidth = widget.contentWidth;

  @override
  late double toolTipHeight = widget.contentHeight;

  double _getHorizontalSpace() {
    var space = widget.position!.getCenter() - (widget.contentWidth / 2);
    if (space + widget.contentWidth > widget.screenSize.width) {
      space = widget.screenSize.width - widget.contentWidth - widget.horizontalPaddingFromParent.right;
    } else if (space < (widget.contentWidth / 2)) {
      space = widget.horizontalPaddingFromParent.left;
    }
    return space;
  }

  double _getVerticalSpace(double contentY, bool isArrowUp) {
    if (isArrowUp) {
      return contentY - widget.horizontalPaddingFromParent.top;
    } else {
      return contentY - widget.horizontalPaddingFromParent.bottom;
    }
  }

  void onSizeChange(Size? size) {
    var tempPos = position;
    tempPos = Offset(position!.dx, position!.dy + size!.height);
    tooltipWidth = size.width;
    toolTipHeight = size.height;
    setState(() => position = tempPos);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final arrowPainter = widget.arrowPainterBuilder?.call(isArrowUp);

    final Widget child;

    if (arrowPainter == null) {
      child = widget.container;
    } else {
      final arrowLeftPosition = _getArrowLeft(arrowPainter.width);
      final arrowRightPosition = arrowLeftPosition != null ? null : _getArrowRight(arrowPainter.width);

      child = Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: arrowLeftPosition,
            right: arrowRightPosition,
            top: -arrowPainter.height,
            child: CustomPaint(
              painter: arrowPainter,
              child: SizedBox(
                height: arrowPainter.height,
                width: arrowPainter.width,
              ),
            ),
          ),
          widget.container,
        ],
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Positioned(
          left: _getHorizontalSpace(),
          top: _getVerticalSpace(contentY, isArrowUp),
          child: FractionalTranslation(
            translation: Offset(0.0, contentFractionalOffset),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0.0, contentFractionalOffset / 10),
                end: !widget.showArrow && !isArrowUp ? const Offset(0.0, 0.0) : const Offset(0.0, 0.100),
              ).animate(_movingAnimation),
              child: Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: widget.onTooltipTap,
                  child: Container(
                    padding: EdgeInsets.only(top: paddingTop),
                    color: Colors.transparent,
                    child: Center(
                      child: MeasureSize(
                        onSizeChange: onSizeChange,
                        child: child,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
