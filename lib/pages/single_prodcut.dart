import 'package:flutter/material.dart';
import 'package:flutter_api_example/models/poduct_model.dart';
import 'package:flutter_api_example/services/api/api_service.dart';

class SingleProduct extends StatelessWidget {
  final int productId;
  SingleProduct({super.key, required this.productId});

  final ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Product>(
          future: apiService.fetchProductById(productId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No data!'));
              } else {
                Product product = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 280,
                        width: double.infinity,
                        child: Center(
                          child: Image.network(
                            product.image,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '\$${product.price}',
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        product.description,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
