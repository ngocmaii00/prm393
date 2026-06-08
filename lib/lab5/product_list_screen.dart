import 'package:flutter/material.dart';

import '../Product.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final Map<String, bool> _favorites = {};
  final Map<String, int> _ratings = {};

  bool _isFavorite(Product product) => _favorites[product.id] ?? false;

  int _ratingOf(Product product) => _ratings[product.id] ?? 0;

  void _setFavorite(Product product, bool value) {
    setState(() {
      _favorites[product.id] = value;
    });
  }

  void _toggleFavorite(Product product) {
    _setFavorite(product, !_isFavorite(product));
  }

  void _setRating(Product product, int rating) {
    setState(() {
      _ratings[product.id] = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    final products = Product.list;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab5 - Shopping Mall'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: _SearchHeader()),
            SliverPadding(
              padding: const EdgeInsets.all(10),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final product = products[index];
                  return _ProductCard(
                    product: product,
                    favorite: _isFavorite(product),
                    rating: _ratingOf(product),
                    onFavoritePressed: () => _toggleFavorite(product),
                    onRatingChanged: (rating) => _setRating(product, rating),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ProductDetailScreen(
                            product: product,
                            favorite: _isFavorite(product),
                            rating: _ratingOf(product),
                            onFavoriteChanged: (value) {
                              _setFavorite(product, value);
                            },
                            onRatingChanged: (rating) {
                              _setRating(product, rating);
                            },
                          ),
                        ),
                      );
                    },
                  );
                }, childCount: products.length),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.62,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchHeader extends StatelessWidget {
  const _SearchHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff053c75),
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 14),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          children: [
            Icon(Icons.search, color: Color(0xff053c75)),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Tìm laptop, điện thoại, phụ kiện...',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xFF777777)),
              ),
            ),
            Icon(Icons.camera_alt_outlined, color: Color(0xff053c75)),
          ],
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.product,
    required this.favorite,
    required this.rating,
    required this.onFavoritePressed,
    required this.onRatingChanged,
    required this.onTap,
  });

  final Product product;
  final bool favorite;
  final int rating;
  final VoidCallback onFavoritePressed;
  final ValueChanged<int> onRatingChanged;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final price = '\$${product.price.toStringAsFixed(2)}';

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    product.image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const ColoredBox(
                      color: Color(0xFFFFEEE8),
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: Color(0xff053c75),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      color: const Color(0xff053c75),
                      child: const Text(
                        'Mall',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Material(
                      color: Colors.white.withValues(alpha: 0.9),
                      shape: const CircleBorder(),
                      child: IconButton(
                        iconSize: 20,
                        visualDensity: VisualDensity.compact,
                        onPressed: onFavoritePressed,
                        icon: Icon(
                          Icons.favorite,
                          color: favorite
                              ? const Color(0xffd12600)
                              : const Color(0xffe0e0e0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: ColoredBox(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        price,
                        style: const TextStyle(
                          color: Color(0xff053c75),
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const Spacer(),
                      _RatingStars(value: rating, onChanged: onRatingChanged),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.local_fire_department,
                            size: 14,
                            color: Color(0xff053c75),
                          ),
                          const SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              'Đã bán ${int.parse(product.id) * 83 + 120}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xFF777777),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RatingStars extends StatelessWidget {
  const _RatingStars({required this.value, required this.onChanged});

  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        final starValue = index + 1;
        return InkResponse(
          radius: 18,
          onTap: () => onChanged(starValue),
          child: Icon(
            starValue <= value ? Icons.star : Icons.star_border,
            size: 18,
            color: const Color(0xFFFFB300),
          ),
        );
      }),
    );
  }
}
