import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() {
  runApp(TaxiApp());
}

class TaxiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxi Express',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TaxiHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TaxiHomePage extends StatefulWidget {
  @override
  _TaxiHomePageState createState() => _TaxiHomePageState();
}

class _TaxiHomePageState extends State<TaxiHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<Color?> _colorAnimation;

  bool _isReserved = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _colorAnimation = ColorTween(
      begin: Colors.grey[300],
      end: Colors.blue[800],
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _reserverTaxi() {
    setState(() {
      _isReserved = true;
    });

    // Animation de confirmation
    _animationController.reset();
    _animationController.forward();

    // Afficher un message de confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10),
            Text('Taxi réservé avec succès!'),
          ],
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // En-tête avec animation
              AnimatedBuilder(
                animation: _fadeAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeAnimation.value,
                    child: Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: child,
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.menu, color: Colors.blue[800]),
                          onPressed: () {},
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.blue[100],
                          child: Icon(Icons.person, color: Colors.blue[800]),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Bienvenue sur',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      'TAXI EXPRESS',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40),

              // Carte du taxi avec animation
              Expanded(
                child: AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: Transform.translate(
                        offset: Offset(_slideAnimation.value, 0),
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blue[800]!, Colors.blue[600]!],
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Animation de la voiture
                        Positioned(
                          bottom: 50,
                          left: 20,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.elasticOut,
                            child: Icon(
                              Icons.local_taxi,
                              size: 120,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // Points animés (effet de mouvement)
                        Positioned(
                          bottom: 80,
                          right: 30,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 800),
                            curve: Curves.easeInOut,
                            child: Row(
                              children: List.generate(3, (index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.7),
                                    shape: BoxShape.circle,
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),

                        // Contenu de la carte
                        Padding(
                          padding: EdgeInsets.all(25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Taxi Premium',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Service de qualité supérieure',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 20),

                              // Informations du conducteur
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.blue[800],
                                      size: 30,
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Jean Dupont',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '★★★★★ 4.9',
                                        style: TextStyle(
                                          color: Colors.amber,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),

              // Boutons d'action
              AnimatedBuilder(
                animation: _fadeAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeAnimation.value,
                    child: Transform.translate(
                      offset: Offset(0, -_slideAnimation.value),
                      child: child,
                    ),
                  );
                },
                child: Row(
                  children: [
                    // Bouton Contact
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.blue[800]!),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              // Action pour contacter
                            },
                            borderRadius: BorderRadius.circular(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.phone, color: Colors.blue[800]),
                                SizedBox(width: 10),
                                Text(
                                  'Contact',
                                  style: TextStyle(
                                    color: Colors.blue[800],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 15),

                    // Bouton Réserver
                    Expanded(
                      flex: 3,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        height: 60,
                        decoration: BoxDecoration(
                          gradient:
                              _isReserved
                                  ? LinearGradient(
                                    colors: [Colors.green, Colors.green[700]!],
                                  )
                                  : LinearGradient(
                                    colors: [
                                      Colors.blue[800]!,
                                      Colors.blue[600]!,
                                    ],
                                  ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _reserverTaxi,
                            borderRadius: BorderRadius.circular(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _isReserved ? Icons.check : Icons.local_taxi,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  _isReserved ? 'Réservé!' : 'Réserver Taxi',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Statut de réservation
              AnimatedBuilder(
                animation: _fadeAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeAnimation.value,
                    child: Center(
                      child: Text(
                        _isReserved
                            ? '✅ Votre taxi arrive dans 5 minutes'
                            : '🚗 Prêt à vous emmener où vous voulez',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
