import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../models/plan_model.dart';
import '../../../theme/app_colors.dart';

class RazorpaySimulationSheet extends StatefulWidget {
  final SubscriptionPlanModel plan;
  final Function(String paymentId) onPaymentSuccess;

  const RazorpaySimulationSheet({
    super.key,
    required this.plan,
    required this.onPaymentSuccess,
  });

  @override
  State<RazorpaySimulationSheet> createState() =>
      _RazorpaySimulationSheetState();
}

class _RazorpaySimulationSheetState extends State<RazorpaySimulationSheet> {
  int _currentStep = 0; // 0: Select Method, 1: Processing, 2: Success
  String _selectedMethod = "GPay";

  void _processPayment() async {
    setState(() => _currentStep = 1);
    await Future.delayed(const Duration(milliseconds: 2200));
    setState(() => _currentStep = 2);
    await Future.delayed(const Duration(milliseconds: 1000));
    Get.back();
    widget.onPaymentSuccess(
      "pay_test_${DateTime.now().millisecondsSinceEpoch}",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF0C2340), // Official Razorpay Dark Blue
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Razorpay Brand Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: const BoxDecoration(
              color: Color(0xFF07192E),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0C2340),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.flash_on_rounded,
                        size: 14,
                        color: Color(0xFF0C8CE9),
                      ),
                      SizedBox(width: 4),
                      Text(
                        "Razorpay",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF59E0B).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    "TEST MODE",
                    style: TextStyle(
                      color: Color(0xFFF59E0B),
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  "₹${widget.plan.price}.00",
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.white70,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),

          // Merchant & Order Summary
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: const Color(0xFF0A1F36),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Image.asset(
                    'assets/image/image.png',
                    fit: BoxFit.contain,
                    errorBuilder: (c, e, s) => const Icon(
                      Icons.school,
                      color: AppColors.primary,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "CareerMarg Private Limited",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        widget.plan.title,
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Step Body
          if (_currentStep == 0) _buildPaymentSelectionView(),
          if (_currentStep == 1) _buildProcessingView(),
          if (_currentStep == 2) _buildSuccessView(),
        ],
      ),
    );
  }

  Widget _buildPaymentSelectionView() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "PREFERRED PAYMENT METHODS",
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF64748B),
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 12),

          // UPI Row
          _buildPaymentTile(
            title: "Google Pay / PhonePe / Paytm",
            subtitle: "Instant approval via UPI apps",
            icon: Icons.account_balance_wallet_outlined,
            methodKey: "GPay",
          ),
          _buildPaymentTile(
            title: "Cards (Credit/Debit)",
            subtitle: "Visa, Mastercard, RuPay, Maestro",
            icon: Icons.credit_card_rounded,
            methodKey: "Card",
          ),
          _buildPaymentTile(
            title: "Netbanking",
            subtitle: "All Indian banks supported",
            icon: Icons.account_balance_rounded,
            methodKey: "Netbanking",
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0C8CE9), // Razorpay Blue
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _processPayment,
              child: Text(
                "Pay ₹${widget.plan.price}",
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.shield_rounded, size: 14, color: Color(0xFF10B981)),
                SizedBox(width: 4),
                Text(
                  "Secured by Razorpay • 256-bit SSL Encryption",
                  style: TextStyle(
                    fontSize: 10.5,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required String methodKey,
  }) {
    final isSelected = _selectedMethod == methodKey;
    return GestureDetector(
      onTap: () => setState(() => _selectedMethod = methodKey),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0F9FF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF0C8CE9)
                : const Color(0xFFE2E8F0),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: const Color(0xFF0C8CE9), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_off_rounded,
              color: isSelected
                  ? const Color(0xFF0C8CE9)
                  : const Color(0xFFCBD5E1),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProcessingView() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CupertinoActivityIndicator(radius: 18, color: Color(0xFF0C8CE9)),
          SizedBox(height: 20),
          Text(
            "Processing Payment...",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Connecting to your bank. Please do not press back or refresh.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFF10B981),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 32,
            ),
          ).animate().scale(duration: 300.ms, curve: Curves.easeOutBack),
          const SizedBox(height: 16),
          const Text(
            "Payment Successful",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }
}
