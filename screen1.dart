import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoecart/cart_list.dart';
import 'package:shoecart/product_list.dart';
import 'package:shoecart/cart_provider.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});
  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  int currentPage = 0;
  List<Widget> pages = [
    ProductList(),
    CartList()
  ];
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context).cart;
    final cartItemCount = cart.length;
     
    return  Scaffold(
        bottomNavigationBar: 
       
         BottomNavigationBar(
          currentIndex: currentPage,
          selectedItemColor: Colors.amber,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          iconSize: 30,
          onTap: (value) {
            setState(() {
              currentPage = value;
            });
            
          },
          items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,),label: ""),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart),
                if (cartItemCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '$cartItemCount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            label: "",
          ),
         ])
         ,
      
        body: IndexedStack(
          index: currentPage,
          children: pages,
        ),
      
    );
  }
}