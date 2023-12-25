import 'package:connection/providers/forgotviewmodel.dart';
import 'package:connection/ui/custom_control.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AppConstant.dart';
import 'page_login.dart';

class PageForgot extends StatelessWidget {
  PageForgot({super.key});
  static String routename= "/forgot";
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ForgotViewModel>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: viewmodel.status == 3
            ? Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage('assets/images/tick.png'),
                      width: 100,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Gữi yêu cầu thành công tái tạo mậy khẩu thành công. Truy cập vào email và làm theo hướng dẫn",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              viewmodel.status = 0;
                              Navigator.popAndPushNamed(
                                  context, PageLogin.routename);
                            },
                            child: Text(
                              "Bấm vào đây ",
                              style: AppConstant.textlink,
                            )),
                        const Text("để đăng nhập"),
                      ],
                    )
                  ],
                ),
              )
            : Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage('assets/images/dauchamhoi.jpg'),
                          width: 200,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                            "Hãy điền email để thự hiện quy trình tái tạo mật khẩu."),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          textController: _emailController,
                          hintText: "Email",
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          viewmodel.errormessage,
                          style: AppConstant.textError,
                        ),
                        GestureDetector(
                            onTap: () {
                              final email = _emailController.text.trim();
                              viewmodel.forgotPassword(email);
                            },
                            child:
                                const CustomButton(textButton: "Gữi yêu cầu")),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () => Navigator.of(context)
                                .popAndPushNamed(PageLogin.routename),
                            child: Text("Đăng nhập >>",
                                style: AppConstant.textlink)),
                      ],
                    ),
                  ),
                  viewmodel.status == 1
                      ? CustomSpinner(size: size)
                      : Container(),
                ],
              ),
      ),
    ));
  }
}
