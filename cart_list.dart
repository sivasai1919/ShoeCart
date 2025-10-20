import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoecart/cart_provider.dart';

class CartList extends StatelessWidget {
  const CartList({super.key});

  int calculateTotal(List<Map<String, dynamic>> cart) {
    return cart.fold(0, (total, item) => total + (item['price'] as int));
  }

  void showCheckoutDialog(BuildContext context, int total) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Checkout", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Total Amount: ₹$total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Thank you for your purchase!", style: TextStyle(fontSize: 16)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context).cart;
    final total = calculateTotal(cart);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      ),
      body: cart.isEmpty 
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 100,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 20),
                Text(
                  'Your cart is empty',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Add some shoes to get started!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          )
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    final cartItem = cart[index];
                    return ListTile(
                     title: Text(cartItem['title'].toString(),
                     style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                     ),
                     subtitle: Text("Size: ${cartItem['size']} - ₹${cartItem['price']}"),
                     leading: CircleAvatar(
                      backgroundImage: AssetImage(cartItem['img'] as String),
                      radius: 30,
                      backgroundColor: Colors.amber,
                      
                     ),
                     trailing: IconButton(onPressed: (){
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(title: Text("Delete Product",style: TextStyle(fontSize: 16),),
                        content: Text("Are you sure the remove the product from your cart?"),
                        actions: [
                          TextButton(onPressed: (){
                            Provider.of<CartProvider>(context,listen: false).removeProduct(cartItem);
                            Navigator.of(context).pop();
                          }, child: Text("yes",style: TextStyle(color: Colors.blue),),),
                          TextButton(onPressed: (){
                            Navigator.of(context).pop();
                          },
                           child: Text("no",style: TextStyle(color: Colors.red),),),
                        ],
                        );
                      },);
                     }, 
                     icon: Icon(Icons.delete,color: Colors.red,)
                     ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border(top: BorderSide(color: Colors.grey[300]!)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total:",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "₹$total",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber[700]),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => showCheckoutDialog(context, total),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          "Checkout",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
    );
  }
}