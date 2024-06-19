import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/routes/app_routes.dart';
import '../providers/product_provider.dart';
import '../widgets/drawer_widget.dart';

class ProductDetailView extends ConsumerWidget {
  final String productId;

  const ProductDetailView({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productDetailProvider(productId));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Detail View"),
      ),
      drawer: const DrawerWidget(),
      body: product.when(
        data: (product) => Column(
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              product.urlImage,
                              // height: 200, // Ajusta la altura según tus necesidades
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  '\$ ${product.price.toStringAsFixed(2)}', // Formato de precio
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 18.0,
                                  ),
                                ),
                                Text(
                                  '\$ ${product.stock.toStringAsFixed(2)}', // Formato de stock
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.blue),
                        ),
                        onPressed: () => context.push(AppRoutes.createUpdate),
                        child: const SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Actualizar",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
