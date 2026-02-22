import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../util/import/domain.dart';

class OrderProvider extends ChangeNotifier {
  Order? _activeOrder;
  bool _isLoading = false;

  Order? get activeOrder => _activeOrder;
  bool get isLoading => _isLoading;

  // Mock repository logic
  Future<void> createOrder({
    required List<CartItem> items,
    required double subtotal,
    required double deliveryFee,
    required PaymentMethodType paymentMethod,
  }) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    final total = subtotal + deliveryFee;
    final now = DateTime.now();

    // Generate mock PIX code if needed
    final pixCode = paymentMethod == PaymentMethodType.pix
        ? '00020126580014BR.GOV.BCB.PIX0136123e4567-e89b-12d3-a456-426614174000520400005303986540510.005802BR5913Loja Caramelo6008Brasilia62070503***63041D3D'
        : null;

    _activeOrder = Order(
      id: 'ORD-${now.millisecondsSinceEpoch}',
      items: List.from(items),
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      total: total,
      paymentMethod: paymentMethod,
      status: OrderStatus.awaitingPayment,
      createdAt: now,
      pixCode: pixCode,
    );

    _isLoading = false;
    notifyListeners();

    // Start simulation automatically if PIX (waiting for payment simulation)
    // In a real app, this would be triggered by a webhook or polling
    if (paymentMethod == PaymentMethodType.pix) {
      _startPixSimulation();
    } else {
      // Simulate immediate payment for credit card
      _updateStatus(OrderStatus.paymentConfirmed);
      _startOrderFlowSimulation();
    }
  }

  void cancelOrder() {
    if (_activeOrder != null) {
      _updateStatus(OrderStatus.canceled);
      // In a real app, might want to keep it in history but clear active
      // For demo, we keep it to show "Canceled" state
    }
  }

  void clearActiveOrder() {
    _activeOrder = null;
    notifyListeners();
  }

  // Simulation Helpers
  void _updateStatus(OrderStatus newStatus) {
    if (_activeOrder != null) {
      _activeOrder = _activeOrder!.copyWith(
        status: newStatus,
        updatedAt: DateTime.now(),
      );
      notifyListeners();
    }
  }

  void _startPixSimulation() {
    // Simulate user paying after 10 seconds
    Timer(const Duration(seconds: 10), () {
      if (_activeOrder?.status == OrderStatus.awaitingPayment) {
        _updateStatus(OrderStatus.paymentConfirmed);
        _startOrderFlowSimulation();
      }
    });
  }

  void _startOrderFlowSimulation() {
    // Confirmed -> Preparing (5s)
    Timer(const Duration(seconds: 5), () {
      if (_activeOrder?.status == OrderStatus.paymentConfirmed) {
        _updateStatus(OrderStatus.preparing);
      }
    });

    // Preparing -> Out for Delivery (10s)
    Timer(const Duration(seconds: 15), () {
      if (_activeOrder?.status == OrderStatus.preparing) {
        _updateStatus(OrderStatus.outForDelivery);
      }
    });

    // Out for Delivery -> Delivered (10s)
    Timer(const Duration(seconds: 25), () {
      if (_activeOrder?.status == OrderStatus.outForDelivery) {
        _updateStatus(OrderStatus.delivered);
      }
    });
  }
}
