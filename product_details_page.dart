import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoecart/cart_provider.dart';
class ProductDetailsPage extends StatefulWidget {
  final Map<String,dynamic> product;

  const ProductDetailsPage({super.key,required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedSize = 0;
  void onTap(){
    if(selectedSize !=0){
    Provider.of<CartProvider>(context,listen: false).addProduct(
      {
        'id' : widget.product['id'],
        'title':widget.product['title'],
        'price' : widget.product['price'],
        'company': widget.product['company'],
        'size': selectedSize,
        'img' : widget.product['img'],
      },
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("product added to a cart")),),
    );
    // Navigate back to home screen after adding to cart
    Navigator.of(context).pop();
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("please select a size")));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),

      ),
      body: Column(
        children: [
          Center(child: Text(widget.product['title'],style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),)),
          Spacer(),
          SizedBox(
            height: 250,
            child: Image.asset(widget.product['img'] as String)),
          Spacer(flex: 2,),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromRGBO(229, 231, 234, 1),   
              borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
           ),
           child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("₹${widget.product['price']}",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              SizedBox(
               height: 50,
              
                child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: (widget.product['sizes'] as List<int>).length,
                itemBuilder: (context,index){
                  final size = (widget.product['sizes'] as List<int>)[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSize = size;
                          });
                        },
                        child: Chip(label: Text(size.toString()),
                        backgroundColor: selectedSize == size ? Colors.yellow:const Color.fromARGB(255, 227, 222, 222),
                        side: BorderSide(color: const Color.fromARGB(115, 169, 167, 167)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
                        ),
                      ),
                     
                    );
                },
                
                ),
              ),
              
              ElevatedButton(onPressed: onTap,
               style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                minimumSize: Size(double.infinity, 50)
               ),
               child: Text("Add to cart",style: TextStyle(color: Colors.black87,fontSize: 16),),
               ),
            ],
           ),
          ),

      
        ],
      ),
    );
  }
}