import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:users_app/methods/common_methods.dart'; // 引入常用方法库
import 'package:users_app/pages/home_page.dart';
import 'package:users_app/authentication/login_screen.dart';
import '../widgets/loading_dialog.dart';
import 'login_screen.dart'; // 引入登录页面

class SignupScreen extends StatefulWidget {
  // 定义一个 StatefulWidget，用于注册页面
  const SignupScreen({super.key}); // 构造函数，接受一个 key

  @override
  State<SignupScreen> createState() => _SignupScreenState(); // 创建状态
}

class _SignupScreenState extends State<SignupScreen> {
  // 状态类
  TextEditingController userNameTextEditingController =
      TextEditingController(); // 用户名输入控制器
  TextEditingController userPhoneTextEditingController =
      TextEditingController(); // 用户电话输入控制器
  TextEditingController emailTextEditingController =
      TextEditingController(); // 邮箱输入控制器
  TextEditingController passwordTextEditingController =
      TextEditingController(); // 密码输入控制器
  CommonMethods cMethods = CommonMethods(); // 实例化公共方法类

  checkIfNetworkIsAvailable() {
    // 检查网络是否可用
    cMethods.checkConnectivity(context); // 检查网络连接
  }

  bool signUpFormValidation() {
    // 表单验证方法
    if (userNameTextEditingController.text.trim().length < 2) {
      cMethods.displaySnackBar(
          "Your name must be at least 3 characters.", context); // 显示snackbar提示
      return false;
    } else if (userPhoneTextEditingController.text.trim().length < 7) {
      cMethods.displaySnackBar(
          "Your phone number must be at least 8 characters.",
          context); // 显示snackbar提示
      return false;
    } else if (!emailTextEditingController.text.contains("@")) {
      cMethods.displaySnackBar(
          "Please enter a valid email.", context); // 显示snackbar提示
      return false;
    } else if (passwordTextEditingController.text.trim().length < 5) {
      cMethods.displaySnackBar("Your password must be at least 6 characters.",
          context); // 显示snackbar提示
      return false;
    }
    // 如果所有验证都通过，然后调用注册用户函数
    registerNewUser();
    return true; // 假设注册流程始终应该结束为真
  }

  registerNewUser() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          LoadingDialog(messageText: "Registering your account..."),
    );
    final User? userFirebase = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailTextEditingController.text.trim(),
                password: passwordTextEditingController.text.trim()))
        .user;
    if (!context.mounted) return;
    Navigator.pop(context);
    DatabaseReference usersRef =
        FirebaseDatabase.instance.ref().child("users").child(userFirebase!.uid);
    Map userDataMap = {
      "name": userNameTextEditingController.text.trim(),
      "email": emailTextEditingController.text.trim(),
      "phone": userPhoneTextEditingController.text.trim(),
      "id": userFirebase.uid,
      "blockStatus": "no",
    };
    usersRef.set(userDataMap);
    Navigator.push(context, MaterialPageRoute(builder: (c) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    // 构建UI界面
    return Scaffold(
      body: SingleChildScrollView(
        // 可滚动视图
        child: Padding(
          padding: const EdgeInsets.all(10), // 内边距
          child: Column(
            // 垂直布局
            children: [
              Image.asset(
                // 图片资源
                "assets/images/logo.png",
                width: 150,
                height: 150,
              ),
              Text(
                // 文本
                "Create a User\'s Account",
                style: TextStyle(
                    fontSize: 26, fontWeight: FontWeight.bold), // 文本样式
              ),
              Padding(
                padding: const EdgeInsets.all(22), // 内边距
                child: Column(
                  // 垂直布局
                  children: [
                    TextField(
                      // 文本输入框
                      controller: userNameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        // 装饰
                        labelText: "User Name", // 标签
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    TextField(
                      controller: userPhoneTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "User Phone",
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "User Email",
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true, // 密文输入
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "User Password",
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      // 提升按钮
                      onPressed: () {
                        // 点击事件
                        checkIfNetworkIsAvailable(); // 检查网络

                        if (signUpFormValidation()) {
                          // 验证表单
                          print("I\'m Ok!");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple), // 按钮样式
                      child: const Text("Sign Up"), // 按钮文本
                    ),
                  ],
                ),
              ),
              TextButton(
                  // 文本按钮
                  onPressed: () {
                    // 点击事件
                    Navigator.push(
                        context, // 页面跳转
                        MaterialPageRoute(
                            builder: (c) => LoginScreen())); // 到登录页面
                  },
                  child: const Text(
                    "Already have an Account? Login Here", // 文本
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
