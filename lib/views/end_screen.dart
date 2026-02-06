import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_tap/router.dart';
import 'package:quick_tap/constants.dart';
import 'package:quick_tap/game/game_end_state.dart';

class EndScreen extends StatefulWidget {
  final GameEndState gameEndState;

  const EndScreen({
    super.key,
    required this.gameEndState,
  });

  @override
  State<EndScreen> createState() => _EndScreenState();
}

class _EndScreenState extends State<EndScreen>
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
      end: const Offset(0, -0.15),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Logica per determinare lo stile in base al risultato
    final bool isWin = widget.gameEndState == GameEndState.win; // o .win
    final Color themeColor = isWin ? Colors.green : Colors.redAccent;
    final String mainTitle = isWin ? "LEVEL UP!" : "GAME OVER";
    final IconData mainIcon = isWin ? Icons.emoji_events : Icons.sentiment_very_dissatisfied;

    return Scaffold(
      backgroundColor: Colors.white, // Sfondo pulito come il menu
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            constraints: BoxConstraints(
              maxWidth: gameWidth,
              minWidth: MediaQuery.of(context).size.width * 0.3,
            ),
            decoration: BoxDecoration(
              color: themeColor.withValues(alpha: 0.15), // Tonalità leggera del colore tema
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: themeColor.withValues(alpha: 0.3), width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icona Animata Floating
                SizedBox(
                  height: 120,
                  child: SlideTransition(
                    position: _offsetAnimation,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(mainIcon, color: themeColor.withValues(alpha: 0.4), size: 110),
                        Icon(mainIcon, color: themeColor, size: 100),
                      ],
                    ),
                  ),
                ),

                // Titolo principale
                Text(
                  mainTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: themeColor,
                    fontWeight: FontWeight.bold,
                    shadows: const [
                      Shadow(offset: Offset(2, 2), blurRadius: 4.0, color: Colors.black12)
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Sottotitolo informativo
                // Text(
                //   "Livello ${widget.currentLevel.number}",
                //   style: TextStyle(fontSize: 20, color: themeColor.withValues(alpha: 0.8)),
                // ),
                
                const SizedBox(height: 40),

                // Bottone Riprova / Prossimo
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => context.goNamed(AppRoute.game.name),
                  child: Text(
                    isWin ? 'Continua' : 'Riprova',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 12),

                // Bottone Menu
                TextButton(
                  onPressed: () => context.goNamed(AppRoute.menu.name),
                  child: Text(
                    'Torna al Menu',
                    style: TextStyle(fontSize: 16, color: themeColor.withValues(alpha: 0.7)),
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