import 'package:flutter/material.dart';
import 'package:letzmeet/utils/colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const PrimaryButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent,
            elevation: 15,
            shadowColor: secondaryBackgroundColor,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: buttonColor))),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
