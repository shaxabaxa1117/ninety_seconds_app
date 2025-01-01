import 'package:flutter/material.dart';
import 'package:ninenty_second_per_word_app/frontend/style/app_colors.dart';

class CustomFillAlertDialog extends StatelessWidget {
  const CustomFillAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: const Color.fromARGB(255, 34, 34, 34),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: Colors.orangeAccent,
              size: 50,
            ),
            const SizedBox(height: 15),
            Text(
              'Please fill in all fields',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.greenColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Ok',
                style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
