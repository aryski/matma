import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:matma/common/items/animations/default_game_item_animations.dart';
import 'package:matma/equation/items/board/cubit/board_cubit.dart';

class BoardDesign extends StatelessWidget {
  const BoardDesign({
    super.key,
    required this.frameColor,
    required this.fillColor,
  });
  final double outRadiusFactor = 0.16;
  final double inRadiusFactor = 0.05;

  final Color frameColor;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return ClipRRect(
          borderRadius:
              BorderRadius.circular(constrains.maxHeight * outRadiusFactor),
          child: Container(
            color: frameColor,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(constrains.maxHeight * inRadiusFactor),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    constrains.maxHeight * (outRadiusFactor - inRadiusFactor),
                  ),
                  child: Container(
                    color: fillColor,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
