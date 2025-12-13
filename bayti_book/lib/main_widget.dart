import 'package:flutter/material.dart';
import 'login_widget.dart';
class MainWidget extends StatelessWidget {
    final String title;
    final double width;
    final double height;
    const MainWidget({
            Key? key,
            required this.title,
            required this.width,
            required this.height,
            }) : super(key: key);
    @override
        Widget build(BuildContext context) {
            return MaterialApp(
                    title: title,
                    home: Scaffold(
                        appBar: AppBar(title: Text(title)),
                        body: Center(
                            child: SizedBox(
                                width: width,
                                height: height,
                                child: const LoginWidget(r: 135, g: 206, b: 250),
                                ),
                            ),
                        ),
                    );
        }
}
