import 'package:flutter/material.dart';
import 'package:mvvm/resources/color.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({super.key, required this.title, this.loading = false, required this.onPress});

  final String title;
  final bool loading;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 50,
        width: 200,
        decoration:
            BoxDecoration(color: AppColors.buttonColor, borderRadius: BorderRadius.circular(15)),
        child: Center(child: loading==true?CircularProgressIndicator(
          color: Colors.white,
        ):Text(title, style: TextStyle(color: AppColors.whiteColor))),
      ),
    );
  }
}
