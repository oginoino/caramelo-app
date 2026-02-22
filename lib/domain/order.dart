import '../util/import/domain.dart';

enum PaymentMethodType { creditCard, pix, cash }

enum OrderStatus {
  awaitingPayment,
  paymentConfirmed,
  preparing,
  outForDelivery,
  delivered,
  canceled,
}

class Order {
  final String id;
  final List<CartItem> items;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final PaymentMethodType paymentMethod;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? pixCode;

  const Order({
    required this.id,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.paymentMethod,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.pixCode,
  });

  Order copyWith({
    String? id,
    List<CartItem>? items,
    double? subtotal,
    double? deliveryFee,
    double? total,
    PaymentMethodType? paymentMethod,
    OrderStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? pixCode,
  }) {
    return Order(
      id: id ?? this.id,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      total: total ?? this.total,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      pixCode: pixCode ?? this.pixCode,
    );
  }
}
