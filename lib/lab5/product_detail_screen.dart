import 'package:flutter/material.dart';

import '../Product.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.favorite,
    required this.rating,
    required this.onFavoriteChanged,
    required this.onRatingChanged,
  });

  final Product product;
  final bool favorite;
  final int rating;
  final ValueChanged<bool> onFavoriteChanged;
  final ValueChanged<int> onRatingChanged;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late bool _favorite;
  late int _rating;

  @override
  void initState() {
    super.initState();
    _favorite = widget.favorite;
    _rating = widget.rating;
  }

  void _setFavorite(bool value) {
    setState(() {
      _favorite = value;
    });
    widget.onFavoriteChanged(value);
  }

  void _setRating(int value) {
    setState(() {
      _rating = value;
    });
    widget.onRatingChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final price = '\$${product.price.toStringAsFixed(2)}';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Chi tiết sản phẩm'),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Color(0xFFE5E5E5))),
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _setFavorite(!_favorite),
                  icon: Icon(
                    _favorite ? Icons.favorite : Icons.favorite_border,
                    color: const Color(0xffd12600)
                  ),
                  label: Text(_favorite ? 'Đã yêu thích' : 'Yêu thích'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('Thêm giỏ'),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            AspectRatio(
              aspectRatio: 1.2,
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const ColoredBox(
                  color: Color(0xFFFFEEE8),
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: Color(0xff053c75),
                    size: 60,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xff053c75),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Mall',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Miễn phí vận chuyển',
                        style: TextStyle(
                          color: Color(0xff053c75),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    price,
                    style: const TextStyle(
                      color: Color(0xff053c75),
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      _RatingStars(value: _rating, onChanged: _setRating),
                      const SizedBox(width: 8),
                      Text(
                        _rating == 0 ? 'Chưa đánh giá' : '$_rating/5 sao',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Thông tin sản phẩm',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 12),
                  _InfoRow(label: 'Mã sản phẩm', value: product.id),
                  _InfoRow(label: 'Kho hàng', value: 'Còn hàng'),
                  _InfoRow(label: 'Bảo hành', value: '12 tháng'),
                ],
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
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starValue = index + 1;
        return InkResponse(
          radius: 22,
          onTap: () => onChanged(starValue),
          child: Icon(
            starValue <= value ? Icons.star : Icons.star_border,
            size: 26,
            color: const Color(0xFFFFB300),
          ),
        );
      }),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF777777),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
