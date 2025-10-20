import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoecart/cart_provider.dart';

import 'package:shoecart/screen1.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => CartProvider(), 
      child:const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShoeCart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),
          prefixIconColor: Colors.black87,
          
          
        
        ),
        textTheme: TextTheme(
          titleMedium: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
          bodySmall: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(fontSize: 25,color: Colors.black87,fontWeight: FontWeight.bold),
          centerTitle: true,
        ),
        colorScheme: ColorScheme.light(),
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    
    _loadApp();
  }

  _loadApp() async {
    // Start animation immediately
    _animationController.forward();
    
    // Wait for minimum display time
    await Future.delayed(Duration(seconds: 1));
    
    if (mounted) {
      setState(() {
        _isLoaded = true;
      });
      
      // Small delay before navigation
      await Future.delayed(Duration(milliseconds: 300));
      
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Screen1()),
        );
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
        animation: _fadeAnimation,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    child: Image.asset(
                      'assets/images/Logo.jpg',
                      height: 200,
                      width: 200,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.shopping_cart,
                            size: 100,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'ShoeCart',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Your Perfect Shoe Collection',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 50),
                  if (!_isLoaded)
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

