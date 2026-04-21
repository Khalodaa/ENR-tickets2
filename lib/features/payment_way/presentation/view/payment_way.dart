// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:enr_tickets/features/payment_way/presentation/manager/payment_cubit.dart';
import 'package:enr_tickets/features/payment_way/presentation/view/payment_screens/payment_webview.dart';

class PaymentWay extends StatelessWidget {
  final String train, trainType, coach, from, to, price, name;
  final List seats;

  const PaymentWay({
    super.key,
    required this.train,
    required this.trainType,
    required this.coach,
    required this.seats,
    required this.from,
    required this.to,
    required this.price,
    required this.name,
  });

  Future<void> _openUrl(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cannot open payment page")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final seatsString = seats.map((e) => e.number).join(",");

    final methods = [
      PaymentMethod(
        name: "Card",
        icon: Icons.credit_card,
        color: Colors.red,
        integrationId: 5598973,
      ),
      PaymentMethod(
        name: "Wallet",
        icon: Icons.account_balance_wallet,
        color: Colors.green,
        integrationId: 5599322,
      ),
    ];
    return BlocProvider(
      create: (_) => PaymentCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Payment"),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: BlocConsumer<PaymentCubit, PaymentState>(
          listener: (context, state) async {
            if (!context.mounted) return;

            if (state is PaymentSuccess) {
              if (state.paymentUrl != null) {
                await _openUrl(context, state.paymentUrl!);
              } else if (state.paymentKey != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PaymentWebView(
                      paymentKey: state.paymentKey!,
                      data: {
                        "from": from,
                        "to": to,
                        "train": train,
                        "trainType": trainType,
                        "coach": coach,
                        "seat": seatsString,
                        "name": name,
                        "price": price,
                        "bookingType": "ذهاب فقط",
                        "ticketId": state.ticketId,
                      },
                    ),
                  ),
                );
              }
            }

            if (state is PaymentError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Payment Failed")));
            }
          },
          builder: (context, state) {
            final cubit = context.read<PaymentCubit>();

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      children: methods.map((m) {
                        return GestureDetector(
                          onTap: () {
                            cubit.payWithPaymob(
                              train: train,
                              trainType: trainType,
                              coach: coach,
                              seats: seatsString,
                              price: price,
                              name: name,
                              integrationId: m.integrationId,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: m.color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: m.color),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(m.icon, size: 30, color: m.color),
                                const SizedBox(height: 8),
                                Text(
                                  m.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: m.color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  if (state is PaymentLoading)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class PaymentMethod {
  final String name;
  final IconData icon;
  final Color color;
  final int integrationId;

  PaymentMethod({
    required this.name,
    required this.icon,
    required this.color,
    required this.integrationId,
  });
}
