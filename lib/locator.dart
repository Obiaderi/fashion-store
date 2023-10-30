import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/providers/cart_vm.dart';
import 'core/providers/category_vm.dart';
import 'core/providers/product_vm.dart';

final allProviders = <SingleChildWidget>[
  ChangeNotifierProvider(create: (_) => ProductVM()),
  ChangeNotifierProvider(create: (_) => ProductCategoryVM()),
  ChangeNotifierProvider(create: (_) => CartVM()),
];
