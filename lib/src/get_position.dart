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

class GetPosition {
  GetPosition({
    required this.renderBox,
    required this.containerRenderBox,
    this.padding = EdgeInsets.zero,
    required this.screenWidth,
    required this.screenHeight,
    this.rootRenderObject,
  }) {
    _getRenderBoxOffset();
  }

  final RenderBox? renderBox;
  final RenderBox? containerRenderBox;
  final EdgeInsets padding;
  final double screenWidth;
  final double screenHeight;
  final RenderObject? rootRenderObject;

  Offset? _boxOffset;
  Offset? _containerBoxOffset;

  void _getRenderBoxOffset() {
    if (renderBox == null) return;

    _boxOffset = renderBox?.localToGlobal(
      Offset.zero,
      ancestor: rootRenderObject,
    );
    _containerBoxOffset = containerRenderBox?.localToGlobal(
      Offset.zero,
      ancestor: rootRenderObject,
    );
  }

  Rect getRect() {
    if (renderBox == null ||
        _boxOffset == null ||
        (_boxOffset?.dx.isNaN ?? true) ||
        (_boxOffset?.dy.isNaN ?? true)) {
      return Rect.zero;
    }

    RenderBox? effectiveRenderBox;
    Offset? effectiveBoxOffset;

    if (containerRenderBox != null) {
      if ((_boxOffset?.dx.isNaN ?? true) || (_boxOffset?.dy.isNaN ?? true)) {
        effectiveRenderBox = renderBox;
        effectiveBoxOffset = _boxOffset;
      } else {
        effectiveRenderBox = containerRenderBox;
        effectiveBoxOffset = _containerBoxOffset;
      }
    } else {
      effectiveRenderBox = renderBox;
      effectiveBoxOffset = _boxOffset;
    }

    final topLeft = effectiveRenderBox!.size.topLeft(effectiveBoxOffset!);
    final bottomRight = effectiveRenderBox.size.bottomRight(effectiveBoxOffset);

    final rect = Rect.fromLTRB(
      topLeft.dx - padding.left < 0 ? 0 : topLeft.dx - padding.left,
      topLeft.dy - padding.top < 0 ? 0 : topLeft.dy - padding.top,
      bottomRight.dx + padding.right > screenWidth
          ? screenWidth
          : bottomRight.dx + padding.right,
      bottomRight.dy + padding.bottom > screenHeight
          ? screenHeight
          : bottomRight.dy + padding.bottom,
    );
    return rect;
  }

  ///Get the bottom position of the widget
  double getBottom() {
    if (renderBox == null || _boxOffset == null || (_boxOffset?.dy.isNaN ?? true)) {
      return padding.bottom;
    }
    final bottomRight = renderBox!.size.bottomRight(_boxOffset!);
    return bottomRight.dy + padding.bottom;
  }

  ///Get the top position of the widget
  double getTop() {
    if (renderBox == null || _boxOffset == null || (_boxOffset?.dy.isNaN ?? true)) {
      return 0 - padding.top;
    }
    final topLeft = renderBox!.size.topLeft(_boxOffset!);
    return topLeft.dy - padding.top;
  }

  ///Get the left position of the widget
  double getLeft() {
    if (renderBox == null || _boxOffset == null || (_boxOffset?.dx.isNaN ?? true)) {
      return 0 - padding.left;
    }
    final topLeft = renderBox!.size.topLeft(_boxOffset!);
    return topLeft.dx - padding.left;
  }

  ///Get the right position of the widget
  double getRight() {
    if (renderBox == null || _boxOffset == null || (_boxOffset?.dx.isNaN ?? true)) {
      return padding.right;
    }
    final bottomRight = renderBox!.size.bottomRight(_boxOffset!);
    return bottomRight.dx + padding.right;
  }

  double getHeight() => getBottom() - getTop();

  double getWidth() => getRight() - getLeft();

  double getCenter() => (getLeft() + getRight()) / 2;

  Offset topLeft() {
    final box = renderBox;
    if (box == null) return Offset.zero;

    return box.size.topLeft(
      box.localToGlobal(
        Offset.zero,
        ancestor: rootRenderObject,
      ),
    );
  }

  Offset getOffset() => renderBox?.size.center(topLeft()) ?? Offset.zero;
}
