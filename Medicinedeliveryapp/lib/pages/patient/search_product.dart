import 'package:flutter/material.dart';
import 'package:medicinedeliveryapp/components/product_card.dart';
import 'package:medicinedeliveryapp/controllers/productsController.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({super.key});

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  String _searchQuery = '';
  List<dynamic> _searchResults = [];

  // Call this function whenever the search query changes
  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    _fetchSearchResults();
  }

  // Fetch search results based on the current search query
  void _fetchSearchResults() async {
    if (_searchQuery.isNotEmpty) {
      final results = await getAllProducts(context, _searchQuery);
      setState(() {
        _searchResults = results;
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Product"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final product = _searchResults[index];
                return Container(
                  child: ProductCard(
                    imageUrl: product['images']
                        [0], // Assuming first image in 'images' list
                    title: product['name'],
                    description: product['description'],
                    price: product['price'].toDouble(),
                    onAddToCart: () {
                      // Implement your add to cart functionality here
                      print('Adding to cart');
                    },
                    onBuyNow: () {
                      // Implement your buy now functionality here
                      print('Buying now');
                    },
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
