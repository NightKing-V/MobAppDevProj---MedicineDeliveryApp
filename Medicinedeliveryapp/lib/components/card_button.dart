import 'package:flutter/material.dart';


class CardButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

   const CardButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
          onTap: onPressed,
          child: Container(
                height: 150,
                width: 100,
                decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: this.color),
                child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  this.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            Icon(
              this.icon,
              size: 50,
            )
          ],
                ),
              ),
        ));
  }
}
