import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_tap/router.dart';
import 'package:quick_tap/constants.dart';

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
        // 1. Usiamo SingleChildScrollView per evitare l'errore se lo schermo è troppo basso
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            // 2. Usiamo BoxConstraints invece di width/height fissi:
            // Definiamo una larghezza massima ma lasciamo che l'altezza si adatti al contenuto
            constraints: BoxConstraints(
              maxWidth: gameWidth, // Larghezza ideale per un menu
              minWidth: MediaQuery.of(context).size.width * 0.3, // Minimo 80% su schermi piccoli
            ),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // La colonna occupa solo lo spazio necessario
              children: [
                // Icona animata
                SizedBox(
                  height: 120, 
                  child: SlideTransition(
                    position: _offsetAnimation,
                    child: Stack(
                      alignment: Alignment.center,
                      children: const [
                        Icon(Icons.flash_on_rounded, color: Colors.orangeAccent, size: 105),
                        Icon(Icons.flash_on_rounded, color: Colors.yellowAccent, size: 100),
                      ],
                    ),
                  ),
                ),
                
                const Text(
                  'Quick Tap!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 44, 
                    color: Colors.white, 
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(offset: Offset(2, 2), blurRadius: 2.0, color: Colors.black45)]
                  ),
                ),

                const SizedBox(height: 10),
                
                const Text(
                  'Follow the rule',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                const Text(
                  'Before time runs out',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),

                // 3. Ridotto lo spazio eccessivo (80 era troppo per contenitori piccoli)
                const SizedBox(height: 40),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  onPressed: () => context.goNamed(AppRoute.game.name),
                  child: const Text(
                    'Start game',
                    style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 0, 52, 95)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}