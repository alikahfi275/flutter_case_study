import 'package:flutter_riverpod/legacy.dart';

import '../models/form_product_model.dart';
import '../../data/models/product_model.dart';

class ProductFormNotifier extends StateNotifier<FormProductModel> {
  ProductFormNotifier() : super(const FormProductModel());

  void updateName(String value) => state = state.copyWith(name: value);
  void updateYear(String value) => state = state.copyWith(year: value);
  void updatePrice(String value) => state = state.copyWith(price: value);
  void updateCpu(String value) => state = state.copyWith(cpu: value);
  void updateDisk(String value) => state = state.copyWith(disk: value);

  void reset() => state = const FormProductModel();

  Product toProduct() {
    final newId = DateTime.now().millisecondsSinceEpoch;

    return Product(
      id: newId,
      name: state.name,
      data: {
        "year": int.tryParse(state.year) ?? 0,
        "price": double.tryParse(state.price) ?? 0.0,
        "CPU model": state.cpu,
        "Hard disk size": state.disk,
      },
    );
  }
}

final productFormProvider =
    StateNotifierProvider<ProductFormNotifier, FormProductModel>(
      (ref) => ProductFormNotifier(),
    );
