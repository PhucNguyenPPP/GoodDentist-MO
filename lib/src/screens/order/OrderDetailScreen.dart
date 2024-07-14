import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/src/api/order/OrderService.dart';
import 'package:good_dentist_mobile/src/models/ApiResponseDTO.dart';
import 'package:good_dentist_mobile/src/models/OrderDetailDTO.dart';
import 'package:good_dentist_mobile/src/models/OrderServiceDTO.dart';
import 'package:good_dentist_mobile/src/screens/common/LoginScreen.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetailScreen extends StatefulWidget {
  final int orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  State<StatefulWidget> createState() {
    return OrderDetailScreenState();
  }
}

class OrderDetailScreenState extends State<OrderDetailScreen> {
  bool _isLoading = true;
  String? _errorMessage;
  ApiResponseDTO<OrderDetailDTO>? _orderDetail;
  String? role;

  Future<void> _fetchOrderDetail() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? dentistId = prefs.getString('dentistId');
      int? expiration = prefs.getInt('expiration');
      role = prefs.getString('role');

      if (dentistId != null && expiration != null && role != null) {
        if (DateTime.now().millisecondsSinceEpoch > expiration) {
          // If expired, navigate to login page
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (Route<dynamic> route) => false,
          );
          return; // Exit early if expired
        }
      }

      ApiResponseDTO<OrderDetailDTO>? orderService =
          await OrderService.getOrderDetailByOrderId(widget.orderId);

      setState(() {
        _orderDetail = orderService;
      });

      if (_orderDetail == null || _orderDetail!.result == null) {
        setState(() {
          _errorMessage = "No order service found";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to load order service: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchOrderDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
        backgroundColor: Colors.purple[400],
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _errorMessage != null
                ? Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  )
                : _orderDetail != null && _orderDetail!.result != null
                    ? _buildOrderService(context)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Image.asset(
                            'assets/images/NoData.jpg',
                            width: 200,
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
      ),
    );
  }

  Widget _buildOrderService(BuildContext context) {
    final NumberFormat _priceFormat =
        NumberFormat.currency(locale: 'vi_VND', symbol: '');
    return Column(
      children: [
        const SizedBox(height: 10),
        const SizedBox(
          child: Text(
            'Services',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            height: 10,
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 0.8, color: Colors.grey)))),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ListView.builder(
                itemCount: _orderDetail!.result!.orderServices.length,
                itemBuilder: (context, index) {
                  OrderServiceDTO orderService =
                      _orderDetail!.result!.orderServices[index];
                  return Container(
                    margin: const EdgeInsets.only(right: 15, left: 15),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 0.8, color: Colors.grey))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Service Name:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              orderService.service.serviceName ?? "No Name",
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Quantity:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "x${orderService.quantity}",
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Price:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${_priceFormat.format(orderService.service.price.toInt())} VND',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.purple),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        Container(
          width: double.maxFinite,
          color: Colors.purple[400], // Changed to pink background color
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    ' Order ID: ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    "${_orderDetail!.result!.orderId.toString()} ",
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    ' Order Name: ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    "${_orderDetail!.result!.orderName} ",
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    ' Order Time: ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    "${DateFormat('yyyy-MM-dd  |  HH:mm').format(DateTime.parse(_orderDetail!.result!.dateTime.toString()))} ",
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    ' Order Total: ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    '${_priceFormat.format(_orderDetail?.result?.price.toInt())}VND ',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
