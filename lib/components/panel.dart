import 'package:flutter/material.dart';

class PanelWidget extends StatefulWidget {
  const PanelWidget({super.key});

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  late Size screenSize;
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Panel Widget'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(4),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ((screenSize.height - 8) / 15).round(),
            itemBuilder: (context, index) {
              return SizedBox(
                height: 15,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: ((screenSize.width - 4) / 15).round(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(2),
                        width: 13,
                        height: 13,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index % 2 == 0 ? Colors.red : Colors.black,
                            border: Border.all(color: Colors.grey),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 2,
                              )
                            ]),
                      );
                    }),
              );
            },
          ),
        ));
  }
}
