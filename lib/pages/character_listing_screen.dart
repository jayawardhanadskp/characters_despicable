import 'package:characters_despicable/styleguide.dart';
import 'package:flutter/material.dart';

import '../models/character.dart';
import '../widgets/character_widget.dart';

class CharacterListingScreen extends StatefulWidget {
  const CharacterListingScreen({super.key});

  @override
  State<CharacterListingScreen> createState() => _CharacterListingScreenState();
}

class _CharacterListingScreenState extends State<CharacterListingScreen> {

  late PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        viewportFraction: 1.0,
        initialPage: currentPage,
        keepPage: false
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0), 
            child: Icon(Icons.search),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 32.0, top: 8),
                child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(text: 'Despicable Me', style: AppTheme.display1),
                        TextSpan(text: '\n'),
                        TextSpan(text: 'Characters', style: AppTheme.display2),
                      ]
                    )
                ),
              ),

        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: characters.length,
            onPageChanged: (int page) {
              setState(() {
                currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return CharacterWidget(
                character: characters[index],
                pageController: _pageController,
                currentPage: index,
              );
            },
          ),)
            ],
          ),
        ),
      ),
    );
  }
}
