# Dart-China

Dart中文社区App，使用Flutter编写

## 功能

[Dart中文社区](https://www.dart-china.org/)使用知名社区软件[Discourse](https://www.discourse.org/)搭建，功能异常丰富。本APP定位为网页端的简化版，只提供社区软件所必需的部分功能。

目前已实现的功能（页面）：

  * 主题列表
  * 主题详情与回复
  * 主题发布与编辑（开发中）
  * 搜索
  * 通知消息
  * 登录
  * 注册
  * 我的
  * 异常上报和事件统计

## 截图

<p float="left">
  <img src="https://raw.github.com/jarontai/dart-china/master/screenshots/home.png" width="32%">
  <img src="https://raw.github.com/jarontai/dart-china/master/screenshots/topic.png" width="32%">
  <img src="https://raw.github.com/jarontai/dart-china/master/screenshots/menu.png" width="32%">
</p>

<p float="left">
  <img src="https://raw.github.com/jarontai/dart-china/master/screenshots/login.png" width="32%">
  <img src="https://raw.github.com/jarontai/dart-china/master/screenshots/profile.png" width="32%">
  <img src="https://raw.github.com/jarontai/dart-china/master/screenshots/search.png" width="32%">
</p>

## 依赖

dart-china 使用了很多第三方库即依赖，秉承主流、专注和高质量的原则，主要的依赖有：

* [flutter_bloc](https://pub.dev/packages/flutter_bloc) - 最核心的状态管理组件，应用整体架构的主梁
* [dio](https://pub.dev/packages/dio) - 最流行的 http client
* [discourse_api](https://github.com/jarontai/discourse_api) - 由作者编写的Discourse API封装库
* [html2md](https://github.com/jarontai/html2md) - 由作者编写的将html转换为markdown的组件
* [freezed](https://pub.dev/packages/freezed) - 不可变对象（模型）代码生成工具
* [flutter_markdown](https://pub.dev/packages/flutter_markdown) - flutter官方提供的markdown渲染组件
* [stash](https://pub.dev/packages/stash) - 功能强大的缓存库
* [cached_network_image](https://pub.dev/packages/cached_network_image) - 图片缓存组件
* [flutter_zoom_drawer](https://pub.dev/packages/flutter_zoom_drawer) - 主页菜单组件
* [reactive_forms](https://pub.dev/packages/reactive_forms) - 功能超丰富的表单处理组件
* [flutter_easyloading](https://pub.dev/packages/flutter_easyloading) - Loading组件
* [bugly_crash](https://pub.dev/packages/bugly_crash) - 腾讯bugly，异常上报组件
* ...

## 文件结构

    .
    ├── dart_china/            DartChina项目代码
    |  ├── ... ...
    |  └── lib/        
    |     ├── features/        所有功能模块
    |     |   ├── ... ... 
    |     |   ├── auth/        具体功能模块
    |     |   |   ├── bloc/    模块的bloc
    |     |   |   └── view/    模块的ui
    |     |   └── ... ...      
    |     ├── models/          模型
    |     ├── repositories/    repository层
    |     ├── widgets/         公共的UI组件
    |     ├── app.dart         主应用
    |     ├── common.dart      公用的常量和方法
    |     ├── config.dart      应用配置
    |     ├── main_dev.dart    dev环境启动文件
    |     ├── main_prod.dart   prod环境启动文件
    |     └── util.dart        工具类
    ├── design/                UI参考图片（只作为UI实现的参考，非正式设计稿）
    ├── screenshots/           应用截图，截自ios模拟器
    └── scripts/               各种使用Dart编写的工具脚本，如：打包apk


## 应用架构

### 简介

// TODO:

### 分层

UI/业务逻辑/数据

// TODO:

### 模块

// TODO: