import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color customColor = Color.fromARGB(255, 25, 154, 142);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: customColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(left: 8.0),
              //   child: IconButton(
              //     icon: Icon(Icons.arrow_back),
              //     onPressed: () {
              //       Navigator.pop(context);
              //     },
              //   ),
              // ),
              SizedBox(height: 16.0),
              Center(
                child: Text(
                  'Terms and Conditions',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Welcome to our Telepharmacy App. By using our services, you agree to comply with and be bound by the following terms and conditions of use. Please read these terms carefully before using our app.',
              ),
              SizedBox(height: 16.0),
              Text(
                '1. **User Agreement:**\n'
                '- You must be 18 years or older to use our app. By using the app, you represent and warrant that you are at least 18 years old.\n'
                '- You agree to provide accurate, current, and complete information during the registration process and to update such information to keep it accurate, current, and complete.',
              ),
              SizedBox(height: 16.0),
              Text(
                '2. **Medical Consultations:**\n'
                '- The telepharmacy app provides access to licensed pharmacists for consultation purposes only.\n'
                '- Consultations do not replace the need for in-person medical examinations, and the app is not a substitute for professional medical advice, diagnosis, or treatment.',
              ),
              SizedBox(height: 16.0),
              Text(
                '3. **Privacy Policy:**\n'
                '- Your privacy is important to us. Please review our Privacy Policy to understand how we collect, use, and disclose your personal information.',
              ),
              SizedBox(height: 16.0),
              Text(
                '4. **Security:**\n'
                '- You are responsible for maintaining the confidentiality of your account information and for restricting access to your mobile device. You agree to accept responsibility for all activities that occur under your account.',
              ),
              SizedBox(height: 16.0),
              Text(
                '5. **User Conduct:**\n'
                '- You agree not to use the app for any unlawful or prohibited purpose or in any manner that could damage, disable, overburden, or impair the app.',
              ),
              SizedBox(height: 16.0),
              Text(
                '6. **Intellectual Property:**\n'
                '- All content, trademarks, service marks, and logos on the app are the property of the app owner and are protected by intellectual property laws.',
              ),
              SizedBox(height: 16.0),
              Text(
                '7. **Disclaimer of Warranty:**\n'
                '- The app is provided "as is" without any warranties, expressed or implied. We do not guarantee that the app will be error-free or uninterrupted.',
              ),
              SizedBox(height: 16.0),
              Text(
                '8. **Limitation of Liability:**\n'
                '- In no event shall the app owner be liable for any direct, indirect, incidental, special, or consequential damages arising out of or in any way connected with the use of the app.',
              ),
              SizedBox(height: 16.0),
              Text(
                '9. **Changes to Terms:**\n'
                '- We reserve the right to modify or replace these terms at any time. Your continued use of the app after any changes constitute your acceptance of the new terms.',
              ),
              SizedBox(height: 16.0),
              Text(
                '10. **Termination:**\n'
                '- We may terminate or suspend your account and access to the app at our sole discretion, without prior notice, for any reason.',
              ),
              SizedBox(height: 16.0),
              Text(
                'By using our Telepharmacy App, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
