import 'package:connectivity_plus/connectivity_plus.dart'; // 导入网络连接检测库
import 'package:flutter/material.dart'; // 导入Flutter基础材料设计库
import 'package:users_app/authentication/login_screen.dart';
import 'package:users_app/authentication/signup_screen.dart';

class CommonMethods {
  // 异步方法，用于检查网络连接
  checkConnectivity(BuildContext context) async {
    var connectionResult =
        await Connectivity().checkConnectivity(); // 获取当前的网络连接状态
    // 判断如果不是通过手机网络或Wi-Fi连接
    if (connectionResult != ConnectivityResult.mobile &&
        connectionResult != ConnectivityResult.wifi) {
      // 如果页面已经被销毁，则不执行任何操作
      if (!context.mounted) return;
      // 调用下面的显示SnackBar的方法，提示网络不可用
      displaySnackBar(
          "Your Internet is not available. Check your connection. Try again.",
          context);
    }
  }

  // 显示SnackBar的方法
  displaySnackBar(String messageText, BuildContext context) {
    var snackBar =
        SnackBar(content: Text(messageText)); // 创建一个SnackBar组件，内容为传入的消息文本
    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar); // 通过ScaffoldMessenger在当前页面显示SnackBar
  }
}
