import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';

import '../../../app/app_nav.dart';
import '../data/student_profile.dart';
import 'new_flashcard_page.dart';

class FlashcardsPage extends StatefulWidget {
  const FlashcardsPage({super.key});

  @override
  State<FlashcardsPage> createState() => _FlashcardsPageState();
}

class _FlashcardsPageState extends State<FlashcardsPage> {
  final String tapMSG = "tap to see the answer";
  bool _mine = true;
  int _tappedIndex = -1;
  final Profile profile = Profile();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flashcards',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'Home',
            onPressed: () {
              AppNav.goHome?.call();
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Profile',
            onPressed: () {
              AppNav.openProfile?.call();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _mine ? Colors.white : Colors.grey,
                        backgroundColor: _mine
                            ? AppColors.primary
                            : Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _mine = true;
                          _tappedIndex = -1;
                        });
                      },
                      child: const Text(
                        'Mine',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _mine = false;
                          _tappedIndex = -1;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _mine
                            ? Colors.grey.shade200
                            : AppColors.primary,
                        foregroundColor: _mine ? Colors.grey : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size(100, 40),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text('Shared'),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: _mine
                      ? profile.mineFlashcards.length
                      : profile.sharedFlashcards.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: SizedBox(
                        width: double.infinity,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          _mine
                                              ? profile
                                                    .mineFlashcards[index]
                                                    .question
                                              : profile
                                                    .sharedFlashcards[index]
                                                    .question,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: TextButton(
                                              onPressed: () {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'TODO flashcard to be shared',
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                "Share",
                                                style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (_mine) {
                                                    profile.mineFlashcards
                                                        .removeAt(index);
                                                  } else {
                                                    profile.sharedFlashcards
                                                        .removeAt(index);
                                                  }
                                                  _tappedIndex = -1;
                                                });
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'Flashcard deleted.',
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                "Delete",
                                                style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 4),
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        if (_tappedIndex == index) {
                                          _tappedIndex = -1;
                                        } else {
                                          _tappedIndex = index;
                                        }
                                      });
                                    },
                                    child: Text(
                                      _mine
                                          ? (_tappedIndex == index
                                                ? profile
                                                      .mineFlashcards[index]
                                                      .answer
                                                : tapMSG)
                                          : (_tappedIndex == index
                                                ? profile
                                                      .sharedFlashcards[index]
                                                      .answer
                                                : tapMSG),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _tappedIndex = -1;
                      _mine = true;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const NewFlashcardPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(150, 55),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text('Add a new card'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
