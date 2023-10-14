import 'package:flutter/material.dart';

class PanelWidget extends StatefulWidget {
  const PanelWidget({super.key, this.pixelSize = 15});
  final double pixelSize;

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  List<List<int>> pixelsToPaint = [];
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            pixelsToPaint = drawLetters(
              constraints,
              30,
              "Ola\nHey",
            );
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ((constraints.maxHeight) / widget.pixelSize).floor(),
              itemBuilder: (context, index) {
                final List<int> pixels = pixelsToPaint[index];
                return SizedBox(
                  height: widget.pixelSize,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          (constraints.maxWidth / widget.pixelSize).floor(),
                      itemBuilder: (context, index) {
                        final bool isPainted = pixels[index] == 1;
                        return Container(
                          margin: const EdgeInsets.all(2),
                          width: widget.pixelSize - 3,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isPainted
                                  ? Colors.red.shade900
                                  : Colors.black,
                              border: Border.all(
                                  color: isPainted
                                      ? Colors.grey
                                      : Colors.grey.shade900),
                              boxShadow: isPainted
                                  ? const [
                                      BoxShadow(
                                        color: Colors.red,
                                        blurRadius: 5,
                                        spreadRadius: 2,
                                      ),
                                      BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 15,
                                          spreadRadius: 1,
                                          blurStyle: BlurStyle.inner)
                                    ]
                                  : null),
                        );
                      }),
                );
              },
            );
          },
        ),
      ),
    );
  }

  List<List<int>> drawLetters(
      BoxConstraints constraints, int pixelSize, String word) {
    final int itensPerLine = (constraints.maxWidth / pixelSize).floor();
    final int itensPerColumn = (constraints.maxHeight / pixelSize).floor();

    final List<List<int>> pixelsToPaint = List.generate(itensPerColumn, (_) {
      return List.generate(itensPerLine, (_) => 0);
    });

    int wordOffset = 1;
    int lineBreak = 0;
    for (int i = 0; i < word.replaceAll(' ', '').length; i++) {
      final letter = word[i];
      if (letter == '\n') {
        lineBreak += 5;
        continue;
      }
      final letterPixels = getLetterPixels(letter, pixelSize);
      for (int j = 0; j < letterPixels.length; j++) {
        for (int k = 0; k < letterPixels[j].length; k++) {
          if (itensPerLine - k - wordOffset < 5) {
            wordOffset = 1;
          }
          pixelsToPaint[j + lineBreak][k + wordOffset] = letterPixels[j][k];
          debugPrint('j: $j, k: $k, wordOffset: $wordOffset');
          debugPrint('pixelsToPaint: ${pixelsToPaint[j]}');
          debugPrint('pixelsToPaintOff: ${pixelsToPaint[j][k + wordOffset]}');
        }
      }
      wordOffset += letterPixels.length + 1;
    }
    return pixelsToPaint;
  }
}

List<List<int>> getLetterPixels(String letter, int wordLength) {
  return switch (letter.toUpperCase()) {
    == 'G' => [
        [1, 1, 1, 1, 1],
        [1, 0, 0, 0, 0],
        [1, 0, 1, 1, 1],
        [1, 0, 0, 0, 1],
        [1, 1, 1, 1, 1]
      ],
    == 'A' => [
        [0, 1, 1, 1, 0],
        [1, 0, 0, 0, 1],
        [1, 1, 1, 1, 1],
        [1, 0, 0, 0, 1],
        [1, 0, 0, 0, 1]
      ],
    == 'B' => [
        [1, 1, 1, 0, 0],
        [1, 0, 1, 0, 0],
        [1, 1, 1, 1, 0],
        [1, 0, 0, 1, 0],
        [1, 1, 1, 1, 0]
      ],
    == 'O' => [
        [1, 1, 1, 1, 1],
        [1, 0, 0, 0, 1],
        [1, 0, 0, 0, 1],
        [1, 0, 0, 0, 1],
        [1, 1, 1, 1, 1]
      ],
    == 'L' => [
        [1, 0, 0, 0, 0],
        [1, 0, 0, 0, 0],
        [1, 0, 0, 0, 0],
        [1, 0, 0, 0, 0],
        [1, 1, 1, 1, 1]
      ],
    == 'H' => [
        [1, 0, 0, 0, 1],
        [1, 0, 0, 0, 1],
        [1, 1, 1, 1, 1],
        [1, 0, 0, 0, 1],
        [1, 0, 0, 0, 1],
      ],
    == 'E' => [
        [1, 1, 1, 1, 1],
        [1, 0, 0, 0, 0],
        [1, 1, 1, 1, 1],
        [1, 0, 0, 0, 0],
        [1, 1, 1, 1, 1]
      ],
    == 'Y' => [
        [1, 0, 0, 0, 1],
        [0, 1, 0, 1, 0],
        [0, 0, 1, 0, 0],
        [0, 0, 1, 0, 0],
        [0, 0, 1, 0, 0]
      ],
    _ => []
  };
}
