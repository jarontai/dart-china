# Dart-China

Dart中文社区App，使用Flutter编写，采用Bloc架构

## 功能

[Dart中文社区](https://www.dart-china.org/)Web端使用知名社区软件[Discourse](https://www.discourse.org/)搭建，本APP定位为Web端的简化版，只提供社区软件所必需的部分功能。

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

备注：Discourse是有官方app的，但其实现方式是网页套壳，使用体验不佳。

## 截图

| home | topic | menu |
| ------------- | ------------- | ------------- |
| <img src="https://raw.github.com/jarontai/dart-china/master/screenshots/home.png">  | <img src="https://raw.github.com/jarontai/dart-china/master/screenshots/topic.png">  | <img src="https://raw.github.com/jarontai/dart-china/master/screenshots/menu.png">  |

| login | profile | search |
| ------------- | ------------- | ------------- |
| <img src="https://raw.github.com/jarontai/dart-china/master/screenshots/login.png">  | <img src="https://raw.github.com/jarontai/dart-china/master/screenshots/profile.png">  | <img src="https://raw.github.com/jarontai/dart-china/master/screenshots/search.png">  |


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
    ├── dart_china/                        DartChina项目代码
    |  ├── .env.example                    dotenv配置模板
    |  └── lib/                
    |    ├── features/                     所有功能模块文件夹
    |    |  ├── register/                  具体的功能模块，比如：注册
    |    |  |  ├── bloc/                   模块业务逻辑文件夹
    |    |  |  |  ├── register_bloc.dart   模块bloc
    |    |  |  |  ├── register_event.dart  模块事件
    |    |  |  |  └── register_state.dart  模块状态
    |    |  |  └── view/                   模块的UI（注意：部分模块没有UI）
    |    |  |     ├── widgets/             模块内部的UI组件
    |    |  |     └── register_page.dart   模块的页面
    |    |  └── ...                        其他功能模块
    |    ├── models/                       模型
    |    ├── repositories/                 Repository层
    |    ├── widgets/                      公共的UI组件
    |    ├── app.dart                      主应用
    |    ├── common.dart                   公用的常量和方法
    |    ├── config.dart                   应用配置
    |    ├── main_dev.dart                 dev环境启动文件
    |    ├── main_prod.dart                prod环境启动文件
    |    └── util.dart                     工具类
    ├── screenshots/                       应用截图，截自ios模拟器
    └── scripts/                           使用Dart编写的各种工具脚本，如：打包apk


## 架构

### 概述

<img src="https://raw.github.com/jarontai/dart-china/master/docs/bloc_architecture_full.png">

注：采自Bloc官网的架构说明图

// TODO:

### 纵向 - 分层

UI/逻辑/数据

// TODO:

### 横向 - 功能模块化

// TODO:

## 问题

已知的待改进的各种不足和问题：

  * 错误处理
  * UI细节
  * ...

// TODO：
