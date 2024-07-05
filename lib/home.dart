import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: CachedNetworkImage(
            imageUrl: 'https://mrshoes.com.pe/wp-content/uploads/2024/06/DQ8563-101-1-350x259.jpg',
            fit: BoxFit.cover,
            width: 150,
            height: 150,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          onPressed: () {
          },
        ),
        title: Text('UnisexStyle'),
      ),
      body: ListView(
        children: <Widget>[
          const Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Bienvenido de nuevo',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, fontFamily: 'DancingScript'),
            ),
          ),
          const Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Últimos productos',
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    width: 150,
                    height: 400,
                    padding: const EdgeInsets.all(10),
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl: 'https://assets.adidas.com/images/w_600,f_auto,q_auto/4eb83ceb9a9c405aa7d5ad6a00bce996_9366/Zapatillas_Courtphase_Negro_GX5948_01_standard.jpg',
                          fit: BoxFit.cover,
                          width: 150,
                          height: 100,
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'Ropa',
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Producto ${index + 1}',
                                    style: const TextStyle(fontSize: 15, fontFamily: 'Kanit',),
                                  ),
                                  RatingBar(
                                    initialRating: 4,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 13,
                                    ratingWidget: RatingWidget(
                                      full: const Icon(Icons.star, color: Colors.amber),
                                      half: const Icon(Icons.star_half, color: Colors.amber),
                                      empty: const Icon(Icons.star_border, color: Colors.amber),
                                    ),
                                    onRatingUpdate: (rating) {
                                      // Handle rating update
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.shopping_cart, color: Colors.grey),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Más vendidos',
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    width: 150,
                    height: 400,
                    padding: const EdgeInsets.all(10),
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl: 'https://assets.adidas.com/images/w_600,f_auto,q_auto/381915eec87143ae8bd2967f9a036098_9366/Zapatillas_adidas_Disney_Lion_King_Racer_TR23_Ninos_Blanco_IF4075_01_standard.jpg',
                          fit: BoxFit.cover,
                          width: 150,
                          height: 100,
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'Ropa',
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Producto ${index + 1}',
                                    style: const TextStyle(fontSize: 15, fontFamily: 'Kanit',),
                                  ),
                                  RatingBar(
                                    initialRating: 4,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 13,
                                    ratingWidget: RatingWidget(
                                      full: const Icon(Icons.star, color: Colors.amber),
                                      half: const Icon(Icons.star_half, color: Colors.amber),
                                      empty: const Icon(Icons.star_border, color: Colors.amber),
                                    ),
                                    onRatingUpdate: (rating) {
                                      // Handle rating update
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.shopping_cart, color: Colors.grey),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrito',
          ),
        ],
      ),
    );
  }
}