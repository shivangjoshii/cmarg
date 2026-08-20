import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../theme/app_colors.dart';
import '../../../../core/utils/app_toast.dart';

class ProfileSetupView extends StatefulWidget {
  const ProfileSetupView({super.key});

  @override
  State<ProfileSetupView> createState() => _ProfileSetupViewState();
}

class _ProfileSetupViewState extends State<ProfileSetupView> {
  final _formKey = GlobalKey<FormState>();

  // Basic Info Controllers
  final _nameController = TextEditingController(text: "Pawan Kumar");
  final _dobController = TextEditingController(text: "14/08/2005");
  final _mobileController = TextEditingController(text: "8521479630");
  final _whatsappController = TextEditingController(text: "8521479630");
  final _emailController = TextEditingController(text: "pawan.neet2026@gmail.com");
  final _cityController = TextEditingController(text: "New Delhi");
  
  String _selectedGender = "Male";
  String _selectedState = "Delhi";
  String _selectedDomicile = "Delhi";

  // NEET Info Controllers
  final _neetYearController = TextEditingController(text: "2026");
  final _rollNumberController = TextEditingController(text: "2601094821");
  final _appNumberController = TextEditingController(text: "260410098234");
  final _scoreController = TextEditingController(text: "600");
  final _rankController = TextEditingController(text: "54120");
  final _categoryRankController = TextEditingController(text: "18400");
  
  String _selectedCategory = "General / UR";
  bool _isPwd = false;

  // Preferences Controllers
  String _preferredCourse = "MBBS";
  String _collegeType = "Government / Semi-Govt";
  String _budgetRange = "INR 10L - 25L";
  String _locationScope = "India & Abroad";

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _mobileController.dispose();
    _whatsappController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    _neetYearController.dispose();
    _rollNumberController.dispose();
    _appNumberController.dispose();
    _scoreController.dispose();
    _rankController.dispose();
    _categoryRankController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      HapticFeedback.mediumImpact();
      AppToast.success("Profile Saved", "Admission preferences updated successfully.");
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Student Profile Setup",
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w800,
            fontSize: 17,
            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("1. Basic Information", Icons.person_outline_rounded, isDark),
              const SizedBox(height: 12),
              _buildFormCard(
                isDark: isDark,
                children: [
                  _buildTextField("Full Name *", _nameController, isDark, icon: Icons.badge_outlined),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField("Date of Birth", _dobController, isDark, icon: Icons.calendar_today_outlined),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDropdownField(
                          label: "Gender",
                          value: _selectedGender,
                          items: const ["Male", "Female", "Other"],
                          onChanged: (val) => setState(() => _selectedGender = val!),
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField("Mobile No. *", _mobileController, isDark, icon: Icons.phone_android_rounded, keyboardType: TextInputType.phone),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextField("WhatsApp No.", _whatsappController, isDark, icon: Icons.chat_outlined, keyboardType: TextInputType.phone),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _buildTextField("Email Address *", _emailController, isDark, icon: Icons.alternate_email_rounded, keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField("City", _cityController, isDark),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDropdownField(
                          label: "State",
                          value: _selectedState,
                          items: const ["Delhi", "Bihar", "Uttar Pradesh", "Maharashtra", "Karnataka", "Rajasthan"],
                          onChanged: (val) => setState(() => _selectedState = val!),
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              _buildSectionTitle("2. NEET Exam Information", Icons.speed_rounded, isDark),
              const SizedBox(height: 12),
              _buildFormCard(
                isDark: isDark,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField("NEET Year", _neetYearController, isDark, keyboardType: TextInputType.number),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDropdownField(
                          label: "Category",
                          value: _selectedCategory,
                          items: const ["General / UR", "OBC-NCL", "EWS", "SC", "ST"],
                          onChanged: (val) => setState(() => _selectedCategory = val!),
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField("Roll Number", _rollNumberController, isDark),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextField("Application No.", _appNumberController, isDark),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField("NEET Score (/720)", _scoreController, isDark, keyboardType: TextInputType.number),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextField("Predicted / All India Rank", _rankController, isDark, keyboardType: TextInputType.number),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Persons with Disability (PwD)",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                            ),
                          ),
                          Text(
                            "Check for special quota reservations",
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                      Switch.adaptive(
                        value: _isPwd,
                        activeColor: AppColors.primary,
                        onChanged: (val) => setState(() => _isPwd = val),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              _buildSectionTitle("3. Admission Preferences", Icons.tune_rounded, isDark),
              const SizedBox(height: 12),
              _buildFormCard(
                isDark: isDark,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdownField(
                          label: "Course",
                          value: _preferredCourse,
                          items: const ["MBBS", "BDS", "BAMS / BHMS", "MD / MS"],
                          onChanged: (val) => setState(() => _preferredCourse = val!),
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDropdownField(
                          label: "Location Scope",
                          value: _locationScope,
                          items: const ["India & Abroad", "India Only", "Abroad Only"],
                          onChanged: (val) => setState(() => _locationScope = val!),
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdownField(
                          label: "Institution Type",
                          value: _collegeType,
                          items: const ["Government / Semi-Govt", "Private Universities", "Deemed Management", "Any"],
                          onChanged: (val) => setState(() => _collegeType = val!),
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDropdownField(
                          label: "Budget",
                          value: _budgetRange,
                          items: const ["Under INR 10L", "INR 10L - 25L", "INR 25L - 50L", "Above 50 Lakhs"],
                          onChanged: (val) => setState(() => _budgetRange = val!),
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: _saveProfile,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Save & Continue",
                        style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w800, fontSize: 15),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon, bool isDark) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.5,
            fontWeight: FontWeight.w800,
            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildFormCard({required List<Widget> children, required bool isDark}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1.2,
        ),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    bool isDark, {
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: TextFormField(
                  controller: controller,
                  keyboardType: keyboardType,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
              dropdownColor: isDark ? AppColors.darkSurface : Colors.white,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
              ),
              items: items.map((item) => DropdownMenuItem(value: item, child: Text(item, maxLines: 1))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}