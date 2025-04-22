
import 'package:flutter/material.dart';
import 'package:moi_market/core/theme/style.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.onTap, this.color});
  final void Function()? onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap ?? () => Navigator.pop(context),
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          width: 50,
          height: 50,
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color ?? Style.primaryWhiteColor,
          ),
          child: const Icon(Icons.arrow_back_rounded, color: Style.primaryColor, size: 30,),
        ),
      ),
    );
  }
}
