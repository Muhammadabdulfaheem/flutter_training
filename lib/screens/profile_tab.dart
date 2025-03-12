import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_training_project/widget/home/localizaedText.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final List<String> items = ["Language"];
  String currentLanguage = 'en';

  void _toggleLanguage() {
    setState(() {
      currentLanguage = context.locale.languageCode == 'en' ? 'ar' : 'en';
    });
    context.setLocale(Locale(currentLanguage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: _toggleLanguage,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Icon(Icons.language),
                        SizedBox(width: 15),
                        LocalizedText(
                          'language',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Spacer(),
                        LocalizedText(
                          currentLanguage == 'en' ? 'english' : 'arabic',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
