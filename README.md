# Dart-China

Dart中文社区App，使用Flutter编写

## 功能

[Dart中文社区](https://www.dart-china.org/)是使用知名社区软件[Discourse](https://www.discourse.org/)搭建，功能异常丰富。本APP定位为Web端的简化版，只实现最常用的部分功能。

目前已实现的功能（页面）：

  * 主题列表
  * 主题详情与回复
  * 主题发布与编辑（构建中）
  * 搜索
  * 通知消息
  * 登录
  * 注册
  * 我的
  * 异常上报和事件统计

## 截图

// TODO:

## 依赖

dart-china 使用了很多第三方库即依赖，秉承主流、专注和高质量的原则，主要的依赖有：

* [flutter_bloc](https://pub.dev/packages/flutter_bloc) - 最核心的状态管理组件，应用整体架构的主梁
* [discourse_api](https://github.com/jarontai/discourse_api) - 由作者编写的对Discourse API的封装库
* [dio](https://pub.dev/packages/dio) - 最流行的 http client
* [freezed](https://pub.dev/packages/freezed) - 不可变对象（模型）的代码生成工具
* [html2md](https://pub.dev/packages/html2md) - 由作者编写的将html转换为markdown的组件
* [flutter_markdown](https://pub.dev/packages/flutter_markdown) - flutter官方提供的markdown渲染组件
* [cached_network_image](https://pub.dev/packages/cached_network_image) - 图片缓存组件
* [flutter_zoom_drawer](https://pub.dev/packages/flutter_zoom_drawer) - 主页菜单组件
* [reactive_forms](https://pub.dev/packages/reactive_forms) - 功能超丰富的表单处理组件
* [flutter_easyloading](https://pub.dev/packages/flutter_easyloading) - Loading组件
* [bugly_crash](https://pub.dev/packages/bugly_crash) - 腾讯bugly，异常上报和事件统计组件
* ...

## 应用架构

### 简介

// TODO:

### 文件结构

    .                 项目根目录
    ├── dart_china/   App项目源码 (内部结构在架构部分进行介绍)
    ├── design/       采自dribbble.com的UI参考图片（只作为UI实现的参考，非设计稿）
    ├── scripts/      各种Dart脚本，如：打包apk

### 分层

// TODO:

### 模块

// TODO: