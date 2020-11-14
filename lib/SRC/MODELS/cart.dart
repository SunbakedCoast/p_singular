import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Cart extends Equatable {
  final String image;
  final String name;
  final int price;

  Cart({@required this.image, @required this.name, @required this.price});

  @override
  // TODO: implement props
  List<Object> get props => [image, name, price];
}
