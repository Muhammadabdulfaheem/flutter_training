import 'package:flutter/material.dart';
import 'package:flutter_training_project/widget/home/localizaedText.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LocalizedText(
                'helloJack',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(height: 10),
            ],
          ),
        ),

        IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert, size: 30, color: Colors.black),
        ),
      ],
    );
  }
}
