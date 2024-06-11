import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:characters_despicable/styleguide.dart';
import 'package:flutter/material.dart';

import '../models/character.dart';

class CharacterDetailScreen extends StatefulWidget {

  final Character character;

  final double _expandedBottomSheetBottomPosition = 0;
  final double _colapseBottomSheetBottomPosition = -250;
  final double _completeColapseBottomSheetBottomPosition = -330;

  const CharacterDetailScreen({super.key, required this.character});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> with AfterLayoutMixin<CharacterDetailScreen>{

  late double _bottomSheetBottomPosition = -330;
  bool isCollapsed = false;

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;


    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: 'background-${widget.character.name}',
            child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: widget.character.colors,
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft
                    )
                )
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _bottomSheetBottomPosition = widget._completeColapseBottomSheetBottomPosition;
                      });
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close, size: 40, color: Colors.white,)),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: Hero(
                        tag: 'image-${widget.character.name}',
                        child: Image.asset(widget.character.imagePath, height: screenHeight * 0.4,))
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
                  child: Hero(
                    tag: 'name-${widget.character.name}',
                    child: Material(
                      color: Colors.transparent,
                      child: Text(widget.character.name, style: AppTheme.heading,), 
                    ),
                  )

                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 8, 32),
                  child: Text(widget.character.description, style: AppTheme.subHeading,),
                )
              ],
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            bottom: _bottomSheetBottomPosition,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: _onTap,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        height: 80,
                        child: Text(
                          'Clips',
                          style: AppTheme.subHeading.copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: _clipWidget(),
                    )
                  ],
                ),
              )
          )
        ],
      )
    );
  }

  Widget _clipWidget() {
    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Column(
            children: [
              roundedContainer(Colors.redAccent),
              const SizedBox(height: 20,),
              roundedContainer(Colors.greenAccent),
            ],
          ),
          const SizedBox(width: 16,),
          Column(
            children: [
              roundedContainer(Colors.orangeAccent),
              const SizedBox(height: 20,),
              roundedContainer(Colors.purple),
            ],
          ),
          const SizedBox(width: 16,),
          Column(
            children: [
              roundedContainer(Colors.grey),
              const SizedBox(height: 20,),
              roundedContainer(Colors.blueGrey),
            ],
          ),
          const SizedBox(width: 16,),
          Column(
            children: [
              roundedContainer(Colors.lightGreenAccent),
              const SizedBox(height: 20,),
              roundedContainer(Colors.pinkAccent),
            ],
          ),
        ],
      ),

    );
  }

  Widget roundedContainer(Color color) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(20))
      ),
    );
  }

  _onTap() {
    setState(() {
      _bottomSheetBottomPosition = isCollapsed
          ? widget._expandedBottomSheetBottomPosition
          : widget._colapseBottomSheetBottomPosition;
      isCollapsed = !isCollapsed;
    });
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isCollapsed = true;
        _bottomSheetBottomPosition = widget._colapseBottomSheetBottomPosition;
      });
    });

    throw UnimplementedError();
  }
}

