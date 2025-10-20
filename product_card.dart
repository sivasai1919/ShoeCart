import 'package:flutter/material.dart';
class ProductCard extends StatelessWidget {
  final String title;
  final int price;
  final String assestName;
  final Color backgroundColor;
  const ProductCard({super.key,required this.title,required this.price,required this.assestName,required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 350,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor,
      ),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(title,style: Theme.of(context).textTheme.titleMedium,),
        
        Text("₹$price",style: Theme.of(context).textTheme.bodySmall,),
        
        Center(child: Image(image: AssetImage(assestName,),height: 250,width: 255,)),
      
        ],
      ),
      
    );
  }
}