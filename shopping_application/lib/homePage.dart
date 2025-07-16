import 'package:flutter/material.dart';
import 'package:shopping_application/global_product.dart';
import 'package:shopping_application/product_card.dart';
import 'package:shopping_application/product_details_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final border = OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromRGBO(225, 206, 225, 1)),
    borderRadius: BorderRadius.horizontal(left: Radius.circular(60)),
  );

  List<String> filters = ['All', 'Adidas', 'Nike', 'Gucci'];
  String selectedFilter = 'All';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Shoes\nCollection',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 120,
              child: Expanded(
                child: ListView.builder(
                  itemCount: filters.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final filter = filters[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = filter;
                          });
                        },
                        child: Chip(
                          side: BorderSide(
                            color: const Color.fromRGBO(245, 247, 249, 1),
                          ),
                          backgroundColor:
                              selectedFilter == filter
                                  ? Theme.of(context).colorScheme.primary
                                  : Color.fromRGBO(245, 247, 249, 1),
                          label: Text(filter),
                          labelStyle: TextStyle(fontSize: 22),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(59)),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return ProductDetailsPage(product: product);
                          },
                        ),
                      );
                    },
                    child: ProductCard(
                      title: product['title'] as String,
                      price: product['price'] as double,
                      image: product['imageUrl'] as String,
                      backgroundColor:
                          index.isEven
                              ? const Color.fromRGBO(218, 240, 253, 1)
                              : const Color.fromRGBO(245, 247, 249, 1),
                    ),
                  );
                },
              ),
            ),
            BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: '',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
