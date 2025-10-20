import 'package:flutter/material.dart';
import 'package:shoecart/product_card.dart';
import 'package:shoecart/product_details_page.dart';
import 'package:shoecart/products.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const [
    'All',
    'Adidas',
    'Nike',
    'Puma'
  ];

  String selectedFilter = '';
  String searchQuery = '';
  late TextEditingController searchController;

  final border = const OutlineInputBorder(
                   borderSide: BorderSide(color:  Color.fromRGBO(225,225,225,1),),
                   borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
                 );
  final focusedBorder = const OutlineInputBorder(
                   borderSide: BorderSide(color: Colors.black87, width: 2),
                   borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
);

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredProducts {
    List<Map<String, dynamic>> filtered = products.where((product) {
      // Filter by brand
      bool brandMatch = selectedFilter == 'All' || 
                       product['company'].toString().toLowerCase() == selectedFilter.toLowerCase();
      
      // Filter by search query
      bool searchMatch = searchQuery.isEmpty ||
                        product['title'].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                        product['company'].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      return brandMatch && searchMatch;
    }).toList();
    
    return filtered;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:  Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/Logo.jpg',
                      height: 50,
                      width: 50,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Search Shoe",
                          prefixIcon: Icon(Icons.search),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          border: border,
                          enabledBorder: border,
                          focusedBorder: focusedBorder,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
               SizedBox(
                height: 120,
                 child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  
                   itemBuilder: (context, index) {
                    final filter = filters[index];
                     return Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 8),
                       child: GestureDetector(
                        onTap: () {
                          setState(() {
                             selectedFilter = filter;   
                          });
                                       
                        },
                         child: Chip(
                          label: Text(filter,),
                          labelStyle: TextStyle(fontSize: 16),
                          padding: EdgeInsets.symmetric(horizontal: 18,vertical: 10),
                          backgroundColor: selectedFilter == filter? Colors.amber: Color.fromRGBO(245, 247, 249, 1),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          side: BorderSide(color: Color.fromRGBO(245, 247, 249, 1)),
                          
                          ),
                       ),
                     );
                   },
                   
                 
                 ),
               ),
               Expanded(
                 child: filteredProducts.isEmpty 
                   ? Center(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Icon(Icons.search_off, size: 64, color: Colors.grey),
                           SizedBox(height: 16),
                           Text(
                             'No shoes found',
                             style: TextStyle(fontSize: 18, color: Colors.grey),
                           ),
                           Text(
                             'Try searching for "Nike", "Adidas", or "Puma"',
                             style: TextStyle(fontSize: 14, color: Colors.grey),
                           ),
                         ],
                       ),
                     )
                   : ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return ProductDetailsPage(product: product);
                            },),);
                          },
                          child: ProductCard(
                            title: product['title'] as String,
                            price: product['price'] as int,
                            assestName: product['img'] as String,
                            backgroundColor: index % 2 == 0 
                                ? const Color.fromARGB(255, 148, 219, 252)
                                : Colors.grey,
                          ),
                        );
                      },
                    ),
               ),
            ],
          ),
        );
      
    
  }
}
  