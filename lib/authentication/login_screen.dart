import 'package:flutter/material.dart';
import 'package:users_app/authentication/signup_screen.dart'; // 导入注册屏幕
import '../methods/common_methods.dart'; // 导入通用方法

class LoginScreen extends StatefulWidget {
  // 定义一个 StatefulWidget，用于登录页面
  const LoginScreen({super.key}); // 构造函数，接受一个 key

  @override
  State<LoginScreen> createState() => _LoginScreenState(); // 创建状态
}

class _LoginScreenState extends State<LoginScreen> {
  // 状态类
  TextEditingController emailTextEditingController =
      TextEditingController(); // 邮箱输入控制器
  TextEditingController passwordTextEditingController =
      TextEditingController(); // 密码输入控制器

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
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        // 装饰
                        labelText: "User Email", // 标签
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 22,
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
                      height: 32,
                    ),
                    ElevatedButton(
                        // 提升按钮
                        onPressed: () async {
                          await CommonMethods()
                              .checkConnectivity(context); // 异步检查网络连接
                          // 如果网络检查通过，再添加登录逻辑
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple), // 按钮样式
                        child: const Text("Login")), // 按钮文本
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
                            builder: (c) => SignupScreen())); // 到注册页面
                  },
                  child: const Text(
                    "Don\'t have an Account? Register Here", // 文本
                    style: TextStyle(color: Colors.grey),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
