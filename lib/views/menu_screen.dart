import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_tap/router.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -0.2), // Movimento verso l'alto
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Screen'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.width * 0.45,
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 100, // Height for the Icon
                child: SlideTransition(
                  position: _offsetAnimation,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Contorno/Sfondo
                      Icon(
                        Icons.flash_on_rounded,
                        color: Colors.orangeAccent, // Colore del contorno
                        size: 105,
                      ),
                      // Interno
                      Icon(
                        Icons.flash_on_rounded,
                        color: Colors.yellowAccent, // Colore interno
                        size: 100,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    children: [
                      // Add your other widgets here
                      const Text(
                        'Quick Tap!',
                        style: TextStyle(
                            fontSize: 44, 
                            color: Colors.white, 
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            shadows: [
                              Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 2.0,
                                color: Colors.black45,
                              ),
                            ]
                          ),
                      ),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 20),
                            const Text(
                              'Follow the rule',
                              style: TextStyle(fontSize: 20, color: Colors.blue),
                            ),
                            
                            const Text(
                              'Before time runs out',
                              style: TextStyle(fontSize: 16, color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 80),
                      ElevatedButton(
                        onPressed: () {
                          context.goNamed(AppRoute.game.name);
                        },
                        child: 
                          const Text(
                              'Start game',
                              style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 0, 52, 95)),
                           ),
                      ),
                    ],
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