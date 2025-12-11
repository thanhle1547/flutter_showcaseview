import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'main.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints(
      breakpoints: const [
        Breakpoint(start: 375, end: 500),
        Breakpoint(start: 501, end: 1000),
      ],
      child: Builder(
        builder: (context) {
          final double width = ResponsiveValue<double>(
            context,
            conditionalValues: const [
              Condition.equals(name: MOBILE, value: 600),
            ],
            defaultValue: 375,
          ).value;
    
          return ResponsiveScaledBox(
            width: width,
            child: MaterialApp(
              title: 'Flutter ShowCase',
              theme: ThemeData(
                primaryColor: const Color(0xffEE5366),
              ),
              debugShowCheckedModeBanner: false,
              home: const HomePage(),
            ),
          );
        }
      ),
    );
  }
}
