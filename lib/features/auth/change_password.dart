import 'package:flutter/material.dart';
import 'package:wellness/popup.dart';
import 'package:wellness/service/auth_service.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$');
  bool _currentPasswordVisibility = false;
  bool _newPasswordVisibility = false;
  bool _confirmPasswordVisibility = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Change Password',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Center(
                  child: Text(
                    'Create a new password',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Your new password must be different\nfrom your current password.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[400],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: 380,
                  child: TextFormField(
                    controller: _currentPasswordController,
                    obscureText: !_currentPasswordVisibility,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Current password is required.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter current password.',
                        prefixIcon: Icon(Icons.lock_outline, size: 24),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _currentPasswordVisibility ? Icons.visibility : Icons.visibility_off,
                            size: 24,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _currentPasswordVisibility = !_currentPasswordVisibility;
                            });
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 17)
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 380,
                  child: TextFormField(
                    controller: _newPasswordController,
                    obscureText: !_newPasswordVisibility,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'New password is required.';
                      }
                      if (!passwordRegex.hasMatch(value)) {
                        return 'Password does not follow requirement';
                      }
                      if (value == _currentPasswordController.text) {
                        return 'New password must be different from current password.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter new password.',
                        prefixIcon: Icon(Icons.lock, size: 24),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _newPasswordVisibility ? Icons.visibility : Icons.visibility_off,
                            size: 24,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _newPasswordVisibility = !_newPasswordVisibility;
                            });
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 17)
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 380,
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: !_confirmPasswordVisibility,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your new password.';
                      }
                      if (value != _newPasswordController.text) {
                        return 'Passwords do not match.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Confirm new password.',
                        prefixIcon: Icon(Icons.lock_clock, size: 24),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _confirmPasswordVisibility ? Icons.visibility : Icons.visibility_off,
                            size: 24,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _confirmPasswordVisibility = !_confirmPasswordVisibility;
                            });
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 17)
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 380,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: TextButton(
                      onPressed: _isLoading ? null : () async {
                        FocusScope.of(context).unfocus();

                        await Future.delayed(const Duration(milliseconds: 200));

                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });

                          final message = await AuthService().changePassword(
                            _currentPasswordController.text.trim(),
                            _newPasswordController.text.trim(),
                          )??"";

                          if (!mounted) return;
                          if (!context.mounted) return;

                          setState(() {
                            _isLoading = false;
                          });

                          if(message.startsWith("Success")) {
                            String popupMessage = message.split("Success: ")[1];
                            Popup.show(context, popupMessage, type: PopupType.success);
                          } else {
                            String popupMessage = message.split("Error: ")[1];
                            Popup.show(context, popupMessage, type: PopupType.error);
                          }

                          if(message.startsWith("Success")){
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      child: _isLoading
                          ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      )
                          : Text(
                        'Change Password',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password Requirements:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildRequirement('At least 8 characters'),
                      _buildRequirement('Different from current password'),
                      _buildRequirement('Contains number, symbol, and alphabet'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequirement(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 16,
            color: Colors.grey[400],
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}