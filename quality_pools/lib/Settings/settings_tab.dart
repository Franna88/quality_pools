import 'package:flutter/material.dart';
import 'package:quality_pools/CommonComponants/quality_pool_header.dart';
import 'package:quality_pools/CommonComponants/reusable_dropdown.dart';
import 'package:quality_pools/CommonComponants/reusable_gradient_button.dart';
import 'package:quality_pools/CommonComponants/reusable_textfields.dart';
import 'package:quality_pools/Login/loginPage.dart';

import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/navbar.dart';
import 'package:quality_pools/CommonComponants/common_button.dart';
import 'package:quality_pools/main_page_layout.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _cellPhoneNumber = TextEditingController();
    final TextEditingController _homeAddress = TextEditingController();

    //GlobalKey for form validation
    final _formKey = GlobalKey<FormState>();

    return MainPageLayout(
      bodyContent: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title is now part of the bodyContent
          Text(
            'Settings',
            style: QualityPoolTextstyle(context).pageTitle,
          ),
          Spacer(),
          // Add the content specific to SettingsTab here
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pool Test Reminder',
                  style: QualityPoolTextstyle(context).blackbodyText,
                ),
                ReusableDropdown(
                    selectedValue: 'Remind me every week',
                    items: [
                      'Remind me every day',
                      'Remind me every 3 days',
                      'Remind me every week',
                      'Remind me every 2 weeks'
                    ],
                    hintText: 'Choose option',
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue;
                      });
                    }),
              ],
            ),
          ),
          Spacer(),
          Form(
              key: _formKey,
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0XFF1A8CF0),
                        Color.fromARGB(255, 5, 83, 165),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6.0,
                        offset: Offset(0, 2),
                      ),
                    ]),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Edit Details',
                          style: QualityPoolTextstyle(context).whiteStyleBody),
                      ReusableTextField(
                        hintText: 'Enter Email',
                        controller: _emailController,
                        labelText: 'Email',
                        imagePath: 'images/email.png',
                        validator: (value) {
                          // Validate email on form submission
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          // Simple email regex validation
                          final emailRegex = RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ReusableTextField(
                        hintText: 'Enter Cell Number',
                        controller: _cellPhoneNumber,
                        labelText: 'Cell Number',
                        imagePath: 'images/phone.png',
                        obscureText: true,
                        validator: (value) {
                          // Validate password on form submission
                          if (value == null || value.isEmpty) {
                            return 'Please enter a cell number';
                          } else if (value.length < 10) {
                            return 'Cell Number must be at least 10 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ReusableTextField(
                        hintText: 'Enter Address',
                        controller: _homeAddress,
                        labelText: 'Address Text',
                        imagePath: 'images/address.png',
                        obscureText: true,
                        validator: (value) {
                          // Validate password on form submission
                          if (value == null || value.isEmpty) {
                            return 'Please enter a cell number';
                          } else if (value.length < 10) {
                            return 'Cell Number must be at least 10 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ReusableTextField(
                        hintText: 'Enter Password',
                        controller: _passwordController,
                        labelText: 'Password',
                        imagePath: 'images/password.png',
                        obscureText: true,
                        validator: (value) {
                          // Validate password on form submission
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                    ]),
              )),
          Spacer(),
          ReusableGradientButton(text: 'Save', onTap: () {}),
        ],
      ),
    );
  }
}
