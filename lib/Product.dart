import 'dart:convert';
import 'dart:io';

class Product {
  String id;
  String name;
  String image;
  double price;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image': image, 'price': price};
  }

  static List<Product> list = [
    Product(
      id: '1',
      name: 'Laptop Dell XPS 13 13.4 inch Core i7',
      image: 'https://bizweb.dktcdn.net/thumb/1024x1024/100/501/863/products/16152-ec469a9d-6509-4b31-b477-7b9f771e65eb-05b0c448-1414-4559-9e0d-680349a2a046-5120fc87-f202-4bcf-8f3a-39ca40bf03c7.jpg?v=1699674133610',
      price: 1200.0,
    ),
    Product(
      id: '2',
      name: 'IPhone 15 Pro Max 256GB chính hãng',
      image:
          'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_7__1.jpg',
      price: 1099.0,
    ),
    Product(
      id: '3',
      name: 'Tai nghe Sony WH-1000XM5',
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-pccN7ngOkmnyX0IUWmuMfAAA9k2UREtAbsKiDRwKLkPWRDE6MWP0Ih3L&s=10',
      price: 349.9,
    ),
    Product(
      id: '4',
      name: 'Chuột Logitech MX Master 3S không dây',
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcZLdJvPof-Vs02myyuqg9h1n3KRhtKmPVpR3tuq8VbA&s=10',
      price: 99.0,
    ),
    Product(
      id: '5',
      name: 'Bàn phím cơ Keychron K2 hot-swap',
      image: 'https://bizweb.dktcdn.net/thumb/grande/100/329/122/products/ban-phim-co-khong-day-keychron-k2-he-special-edition-rgb-hotswap-aluminum-magnetic-sw.jpg?v=1743667826437',
      price: 79.5,
    ),
    Product(
      id: '6',
      name: 'Apple Watch Series 9 GPS viền nhôm',
      image:
          'https://product.hstatic.net/1000300544/product/download_-_2023-09-16t151330.968_369f96739a614354adaf51a4a790b84c.jpeg',
      price: 399.0,
    ),
  ];

  static const int maxLimit = 10;

  static bool add(Product product) {
    if (list.length >= maxLimit) {
      print(
        '\n Vượt quá giới hạn tối đa ($maxLimit sản phẩm). Không thể thêm mới!',
      );
      return false;
    }
    if (list.any((p) => p.id == product.id)) {
      print('\n ID sản phẩm "${product.id}" đã tồn tại.');
      return false;
    }
    list.add(product);
    return true;
  }

  static bool edit(Product product) {
    int index = list.indexWhere((p) => p.id == product.id);
    if (index == -1) {
      print('\n Không tìm thấy sản phẩm có ID: ${product.id}');
      return false;
    }
    list[index] = product;
    return true;
  }

  static List<Product> search(String name) {
    return list
        .where(
          (product) => product.name.toLowerCase().contains(name.toLowerCase()),
        )
        .toList();
  }

  static void increasePrice() {
    list = list.map((product) {
      return Product(
        id: product.id,
        name: product.name,
        image: product.image,
        price: product.price * 1.10,
      );
    }).toList();
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, image: $image, price: $price)';
  }
}

void main() {
  try {
    stdin.lineMode = true;
    stdin.echoMode = true;
  } catch (_) {}

  while (true) {
    print('\n========================================');
    print('       HỆ THỐNG QUẢN LÝ SẢN PHẨM ');
    print('========================================');
    print('1. Hiển thị danh sách sản phẩm');
    print('2. Thêm sản phẩm mới');
    print('3. Thêm sản phẩm từ chuỗi JSON');
    print('4. Sửa sản phẩm');
    print('5. Xóa sản phẩm');
    print('6. Tìm kiếm sản phẩm theo tên');
    print('7. Lọc sản phẩm');
    print('8. Sắp xếp sản phẩm');
    print('9. Tăng giá toàn bộ sản phẩm lên 10%');
    print('10. Thoát chương trình');
    print('========================================');
    stdout.write('Nhập lựa chọn của bạn: ');

    String? choice = stdin.readLineSync(encoding: utf8)?.trim();
    if (choice == null || choice.isEmpty) continue;

    switch (choice) {
      case '1':
        displayList(Product.list);
        break;
      case '2':
        handleAddProduct();
        break;
      case '3':
        handleAddProductFromJson();
        break;
      case '4':
        handleEditProduct();
        break;
      case '5':
        handleDeleteProduct();
        break;
      case '6':
        handleSearchProduct();
        break;
      case '7':
        handleFilterProducts();
        break;
      case '8':
        handleSortProducts();
        break;
      case '9':
        Product.increasePrice();
        print('\nĐã tăng giá tất cả sản phẩm thêm 10%!');
        displayList(Product.list);
        break;
      case '10':
        print('\nCảm ơn bạn đã sử dụng chương trình!');
        exit(0);
      default:
        print('\nLựa chọn không hợp lệ. Vui lòng chọn từ 1 đến 10.');
    }
  }
}

void displayList(List<Product> products) {
  if (products.isEmpty) {
    print('\nDanh sách sản phẩm hiện tại đang trống.');
    return;
  }
  print(
    '\n-------------------------------------------------------------------------------------',
  );
  print(
    '                        DANH SÁCH SẢN PHẨM (${products.length}/${Product.maxLimit})',
  );
  print(
    '-------------------------------------------------------------------------------------',
  );
  print(
    'ID    | Tên sản phẩm                   | Giá (USD)    | Link hình ảnh',
  );
  print(
    '-------------------------------------------------------------------------------------',
  );
  for (var p in products) {
    final idStr = p.id.padRight(5);
    final nameStr =
        (p.name.length > 30 ? p.name.substring(0, 27) + '...' : p.name)
            .padRight(30);
    final priceStr = '\$${p.price.toStringAsFixed(2)}'.padRight(12);
    final imageStr = p.image.length > 25
        ? p.image.substring(0, 22) + '...'
        : p.image;
    print('$idStr | $nameStr | $priceStr | $imageStr');
  }
  print(
    '-------------------------------------------------------------------------------------',
  );
}

void handleAddProduct() {
  if (Product.list.length >= Product.maxLimit) {
    print('\nKhông thể thêm sản phẩm mới!');
    print(
      'Số lượng sản phẩm hiện tại (${Product.list.length}) đã đạt tối đa (${Product.maxLimit}).',
    );
    return;
  }

  print('\n--- THÊM SẢN PHẨM MỚI ---');
  stdout.write('Nhập ID sản phẩm: ');
  String id = stdin.readLineSync(encoding: utf8)?.trim() ?? '';
  if (id.isEmpty) {
    print('ID không được để trống.');
    return;
  }

  if (Product.list.any((p) => p.id == id)) {
    print('ID "$id" đã tồn tại trong hệ thống.');
    return;
  }

  stdout.write('Nhập tên sản phẩm: ');
  String name = stdin.readLineSync(encoding: utf8)?.trim() ?? '';
  if (name.isEmpty) {
    print('Tên sản phẩm không được để trống.');
    return;
  }

  stdout.write('Nhập link hình ảnh: ');
  String image = stdin.readLineSync(encoding: utf8)?.trim() ?? '';
  if (image.isEmpty) {
    print('Hình ảnh không được để trống.');
    return;
  }

  stdout.write('Nhập giá sản phẩm: ');
  String priceInput = stdin.readLineSync(encoding: utf8)?.trim() ?? '';
  double? price = double.tryParse(priceInput);
  if (price == null || price < 0) {
    print('Giá sản phẩm phải là một số dương hợp lệ.');
    return;
  }

  Product newProduct = Product(id: id, name: name, image: image, price: price);
  if (Product.add(newProduct)) {
    print('\nĐã thêm sản phẩm thành công:');
    print(newProduct);
  }
}

void handleAddProductFromJson() {
  if (Product.list.length >= Product.maxLimit) {
    print('\nKhông thể thêm sản phẩm mới!');
    print(
      'Số lượng sản phẩm hiện tại (${Product.list.length}) đã đạt tối đa (${Product.maxLimit}).',
    );
    return;
  }

  print('\n--- THÊM SẢN PHẨM TỪ CHUỖI JSON ---');
  print(
    'Ví dụ chuỗi JSON hợp lệ: {"id": "6", "name": "Bàn di chuột", "image": "mousepad.png", "price": 25.5}',
  );
  stdout.write('Nhập chuỗi JSON: ');
  String jsonStr = stdin.readLineSync(encoding: utf8)?.trim() ?? '';
  if (jsonStr.isEmpty) {
    print('Chuỗi JSON không được để trống.');
    return;
  }

  try {
    Map<String, dynamic> jsonMap = jsonDecode(jsonStr);

    if (!jsonMap.containsKey('id') ||
        jsonMap['id'] == null ||
        jsonMap['id'].toString().trim().isEmpty) {
      print('Thiếu trường hoặc giá trị "id" không hợp lệ trong JSON.');
      return;
    }
    String id = jsonMap['id'].toString();
    if (Product.list.any((p) => p.id == id)) {
      print('ID "$id" trong JSON đã tồn tại trong hệ thống.');
      return;
    }

    Product newProduct = Product.fromJson(jsonMap);
    if (Product.add(newProduct)) {
      print('\nĐã thêm sản phẩm từ JSON factory:');
      print(newProduct);
    }
  } catch (e) {
    print('Định dạng JSON không hợp lệ hoặc lỗi phân tích: $e');
  }
}

void handleEditProduct() {
  print('\n--- SỬA SẢN PHẨM ---');
  stdout.write('Nhập ID sản phẩm cần sửa: ');
  String id = stdin.readLineSync(encoding: utf8)?.trim() ?? '';
  if (id.isEmpty) {
    print('ID không được để trống.');
    return;
  }

  int index = Product.list.indexWhere((p) => p.id == id);
  if (index == -1) {
    print('Không tìm thấy sản phẩm có ID: $id');
    return;
  }

  Product old = Product.list[index];
  print('\nThông tin sản phẩm hiện tại:');
  print(' - Tên: ${old.name}');
  print(' - Hình ảnh: ${old.image}');
  print(' - Giá: \$${old.price.toStringAsFixed(2)}');
  print('-----------------------------------------');

  stdout.write('Nhập tên mới (để trống để giữ nguyên "${old.name}"): ');
  String name = stdin.readLineSync(encoding: utf8)?.trim() ?? '';
  if (name.isEmpty) name = old.name;

  stdout.write('Nhập hình ảnh mới (để trống để giữ nguyên "${old.image}"): ');
  String image = stdin.readLineSync(encoding: utf8)?.trim() ?? '';
  if (image.isEmpty) image = old.image;

  stdout.write(
    'Nhập giá mới (để trống để giữ nguyên "\$${old.price.toStringAsFixed(2)}"): ',
  );
  String priceInput = stdin.readLineSync(encoding: utf8)?.trim() ?? '';
  double price = old.price;
  if (priceInput.isNotEmpty) {
    double? tempPrice = double.tryParse(priceInput);
    if (tempPrice == null || tempPrice < 0) {
      print('Giá trị không hợp lệ. Giữ nguyên giá cũ.');
    } else {
      price = tempPrice;
    }
  }

  Product updated = Product(id: id, name: name, image: image, price: price);
  if (Product.edit(updated)) {
    print('\nĐã cập nhật sản phẩm thành công:');
    print(updated);
  }
}

void handleDeleteProduct() {
  print('\n--- XÓA SẢN PHẨM ---');
  stdout.write('Nhập ID sản phẩm cần xóa: ');
  String id = stdin.readLineSync(encoding: utf8)?.trim() ?? '';
  if (id.isEmpty) {
    print('ID không được để trống.');
    return;
  }

  int index = Product.list.indexWhere((p) => p.id == id);
  if (index == -1) {
    print('Không tìm thấy sản phẩm có ID: $id');
    return;
  }

  Product old = Product.list[index];
  stdout.write(
    'Bạn có chắc chắn muốn xóa sản phẩm "${old.name}" không? (y/n): ',
  );
  String confirm =
      stdin.readLineSync(encoding: utf8)?.trim().toLowerCase() ?? '';
  if (confirm == 'y' || confirm == 'yes') {
    Product.list.removeAt(index);
    print('Đã xóa sản phẩm thành công.');
  } else {
    print('Đã hủy thao tác xóa.');
  }
}

void handleSearchProduct() {
  print('\n--- TÌM KIẾM SẢN PHẨM THEO TÊN ---');
  stdout.write('Nhập từ khóa cần tìm: ');
  String keyword = stdin.readLineSync(encoding: utf8)?.trim() ?? '';
  if (keyword.isEmpty) {
    print('Từ khóa không được để trống.');
    return;
  }

  List<Product> results = Product.search(keyword);
  print('\nTìm thấy ${results.length} sản phẩm tương thích:');
  displayList(results);
}

void handleFilterProducts() {
  print('\n--- LỌC SẢN PHẨM ---');
  print('1. Lọc theo ID');
  print('2. Lọc theo tên sản phẩm');
  print('3. Lọc theo khoảng giá (min - max)');
  print('4. Lọc kết hợp');
  stdout.write('Chọn hình thức lọc: ');
  String choice = stdin.readLineSync(encoding: utf8)?.trim() ?? '';

  switch (choice) {
    case '1':
      stdout.write('Nhập ID cần tìm: ');
      String id = stdin.readLineSync(encoding: utf8)?.trim() ?? '';
      List<Product> results = Product.list.where((p) => p.id == id).toList();
      displayList(results);
      break;

    case '2':
      stdout.write('Nhập Tên cần lọc: ');
      String name = stdin.readLineSync(encoding: utf8)?.trim() ?? '';
      List<Product> results = Product.list
          .where((p) => p.name.toLowerCase().contains(name.toLowerCase()))
          .toList();
      displayList(results);
      break;

    case '3':
      stdout.write('Nhập giá tối thiểu (Min Price): ');
      String minStr = stdin.readLineSync(encoding: utf8)?.trim() ?? '';
      double? min = minStr.isNotEmpty ? double.tryParse(minStr) : null;

      stdout.write('Nhập giá tối đa (Max Price): ');
      String maxStr = stdin.readLineSync(encoding: utf8)?.trim() ?? '';
      double? max = maxStr.isNotEmpty ? double.tryParse(maxStr) : null;

      List<Product> results = Product.list.where((p) {
        if (min != null && p.price < min) return false;
        if (max != null && p.price > max) return false;
        return true;
      }).toList();
      displayList(results);
      break;

    case '4':
      stdout.write('Nhập ID lọc (để trống để bỏ qua): ');
      String idFilter = stdin.readLineSync(encoding: utf8)?.trim() ?? '';

      stdout.write('Nhập Tên lọc (để trống để bỏ qua): ');
      String nameFilter = stdin.readLineSync(encoding: utf8)?.trim() ?? '';

      stdout.write('Nhập giá Min (để trống để bỏ qua): ');
      String minCStr = stdin.readLineSync(encoding: utf8)?.trim() ?? '';
      double? minC = minCStr.isNotEmpty ? double.tryParse(minCStr) : null;

      stdout.write('Nhập giá Max (để trống để bỏ qua): ');
      String maxCStr = stdin.readLineSync(encoding: utf8)?.trim() ?? '';
      double? maxC = maxCStr.isNotEmpty ? double.tryParse(maxCStr) : null;

      List<Product> results = Product.list.where((p) {
        if (idFilter.isNotEmpty && p.id != idFilter) return false;
        if (nameFilter.isNotEmpty &&
            !p.name.toLowerCase().contains(nameFilter.toLowerCase())) {
          return false;
        }
        if (minC != null && p.price < minC) return false;
        if (maxC != null && p.price > maxC) return false;
        return true;
      }).toList();
      displayList(results);
      break;

    default:
      print('Lựa chọn không hợp lệ.');
  }
}

void handleSortProducts() {
  print('\n--- SẮP XẾP SẢN PHẨM ---');
  print('1. Sắp xếp theo Tên sản phẩm');
  print('2. Sắp xếp theo Giá sản phẩm');
  stdout.write('Chọn tiêu chí sắp xếp: ');
  String criteria = stdin.readLineSync(encoding: utf8)?.trim() ?? '';

  if (criteria != '1' && criteria != '2') {
    print('Tiêu chí không hợp lệ.');
    return;
  }

  print('1. Tăng dần (Ascending)');
  print('2. Giảm dần (Descending)');
  stdout.write('Chọn thứ tự sắp xếp: ');
  String order = stdin.readLineSync(encoding: utf8)?.trim() ?? '';

  if (order != '1' && order != '2') {
    print('Thứ tự không hợp lệ.');
    return;
  }

  bool asc = (order == '1');

  if (criteria == '1') {
    Product.list.sort(
      (a, b) => asc ? a.name.compareTo(b.name) : b.name.compareTo(a.name),
    );
  } else {
    Product.list.sort(
      (a, b) => asc ? a.price.compareTo(b.price) : b.price.compareTo(a.price),
    );
  }

  print('\nĐã sắp xếp lại danh sách sản phẩm.');
  displayList(Product.list);
}
