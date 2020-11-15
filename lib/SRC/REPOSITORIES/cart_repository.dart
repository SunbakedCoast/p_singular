
import 'package:p_singular/SRC/MODELS/models.dart';

//TODO GET THIS DONE AFTER THE AUTHENTICATION
abstract class CartRepository{
  Future<List<Cart>> loadCart();
}