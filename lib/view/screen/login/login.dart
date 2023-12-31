import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

enum Language {
  Vietnamese,
  English,
}

Language currentLanguage = Language.Vietnamese;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController countrycode = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  void toggleLanguage() {
    if (currentLanguage == Language.Vietnamese) {
      currentLanguage = Language.English;
    } else {
      currentLanguage = Language.Vietnamese;
    }
    setState(() {});
  }

  @override
  void initState() {
    countrycode.text = "+84";
    super.initState();
  }

  bool isPhoneNumberValid() {
    RegExp regex = RegExp(r'^\d{10}$');
    return regex.hasMatch(phoneNumber.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Không cho phép resize khi bàn phím xuất hiện
      body: Stack(
        children: [
          Container(
            height: 240,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            Container(
                              child: IconButton(
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Navigate back to the previous screen (LoginScreen)
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text.rich(
                        TextSpan(children: [
                          TextSpan(
                              text: "Chào mừng bạn đến với ",
                              style: TextStyle(color: Colors.grey)),
                        ]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Deer Coffee",
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.1,
                          vertical: 20.0,
                        ),
                        child: Container(
                          width: 280,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(16, 4, 4, 4),
                                width: 60,
                                child: TextField(
                                  controller: countrycode,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: phoneNumber,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Nhập số điện thoại",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 240,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // // Get.toNamed(RouteHandler.OTP);
                            // Get.find<AccountViewModel>().onLoginWithPhone(
                            //     countrycode.text + phoneNumber.text);
                          },
                          child: Text('Đăng nhập',
                              style: Get.textTheme.bodyLarge
                                  ?.copyWith(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            // backgroundColor: ThemeColor.primary,
                            textStyle: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      SizedBox(
                        child: InkWell(
                          onTap: () {
                            toggleLanguage();
                          },
                          child: Text(
                            currentLanguage == Language.Vietnamese
                                ? "Tiếng Việt"
                                : "English",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
