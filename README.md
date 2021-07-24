# Dart-China

Dart中文社区App即Dart China，使用Flutter编写，采用[BLoC](https://bloclibrary.dev/)架构，模块化开发方式

## 功能

[Dart中文社区](https://www.dart-china.org/)Web端使用知名社区软件[discourse](https://www.discourse.org/)搭建，本App定位为discourse的简化版，只提供社区软件所必需的部分功能。

本App完全使用Flutter和Dart开发（部分脚本使用原生Dart），支持Android和iOS（理论上也支持发布为Web应用,待验证）。项目代码完全开源，Android版本将直接通过GitHub发布apk文件，iOS版本则将提交到苹果AppStore发布。

App预计将实现的功能（页面）：

  * 主题列表
  * 主题详情与回复
  * 主题发布与编辑
  * 搜索
  * 通知消息
  * 登录
  * 注册
  * 我的
  * 推送
  * 异常上报和运营统计
  * 请求缓存

在Flutter应用开发中，需要重点关注的是状态管理，以及应用整体架构的设计。在Provider、Bloc、Redux、MobX等流行状态库之中，Dart China选择了Bloc，具体原因可以查看[架构](#架构)

备注：Discourse是有官方app的，但其实现方式是网页套壳，使用体验不佳。

## 截图

| home | topic | menu |
| ------------- | ------------- | ------------- |
| <img src="https://raw.github.com/jarontai/dart-china/master/screenshots/home.png">  | <img src="https://raw.github.com/jarontai/dart-china/master/screenshots/topic.png">  | <img src="https://raw.github.com/jarontai/dart-china/master/screenshots/menu.png">  |

| login | profile | search |
| ------------- | ------------- | ------------- |
| <img src="https://raw.github.com/jarontai/dart-china/master/screenshots/login.png">  | <img src="https://raw.github.com/jarontai/dart-china/master/screenshots/profile.png">  | <img src="https://raw.github.com/jarontai/dart-china/master/screenshots/search.png">  |


## 文件结构

    .
    ├── dart_china/                        DartChina项目代码
    |  ├── .env.example                    dotenv配置模板
    |  └── lib/                
    |    ├── features/                     功能模块根目录
    |    |  ├── register/                  具体的功能模块，比如：注册
    |    |  |  ├── bloc/                   模块业务逻辑文件夹
    |    |  |  |  ├── register_bloc.dart   模块的bloc
    |    |  |  |  ├── register_event.dart  模块的事件
    |    |  |  |  └── register_state.dart  模块的状态
    |    |  |  └── view/                   模块的UI（注意：模块可以没有UI）
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


## 依赖

Dart China 使用了很多第三方库即依赖，秉承主流、专注和高质量的原则，主要的依赖有：

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

## 架构

### BLoC

<img src="https://raw.github.com/jarontai/dart-china/master/docs/bloc_architecture_full.png">

* Bloc官网的架构说明图

流行的flutter状态管理组件有provider、bloc、redux等，其中provider稍显单薄，redux又过于繁琐。而bloc的复杂度介于前两者之间，非常适合对架构有追求，需要长期维护的中大型项目。

Bloc的整体设计跟Redux非常相似，UI层负责接受用户或系统产生的事件（Event），事件发送给Bloc。Bloc根据业务规则对不同的Event生成不同的不可变的状态（State），而UI层同时也在监听状态的变化，从而对界面进行更新。

个人总结bloc的优点：

1. 单向数据流，逻辑和UI界限清晰
2. 可以使用状态机的思维方式对状态流转进行抽象
3. 自带分层架构和模块化属性
4. 鼓励使用不可变数据对象
5. 对测试友好

### 分层与模块化

在很多flutter项目中，应用一般都是按页面开发，然后围绕多个Provider+ChangeNotifier展开整个应用架构。个人认为，此种方式下的代码逻辑并不清晰，不利于维护。

软件架构设计中最流行的一种，就是分层模式。在Bloc的架构理念中，应用被分为三层，从上到下依次是：视图（UI）、业务逻辑（bloc）和数据（data）。而数据层可能还包含Repository层、数据提供层（data provider）以及模型（model）等。

Dart China 的架构实现参考[very_good_cli](https://github.com/VeryGoodOpenSource/very_good_cli)及众多bloc教程，使用分层和模块化的开发方式。一个功能就是一个大的模块，它包含一个或多个bloc模块，以及零个或多个页面。而bloc模块又由事件（event）、状态（state）和逻辑（bloc）组成。

功能模块构成示例：

     ├── register/                  具体的功能模块，比如：注册
     |  ├── bloc/                   模块业务逻辑文件夹
     |  |  ├── register_bloc.dart   模块bloc
     |  |  ├── register_event.dart  模块的事件
     |  |  └── register_state.dart  模块的状态
     |  └── view/                   模块的UI（注意：部分模块没有UI）
     |     ├── widgets/             模块内部的UI组件
     |     └── register_page.dart   模块的页面

各个功能模块几乎完全隔离，符合高内聚低耦合的设计原则，代码的维护变得更加直观和方便。当然，随之而来的一个难题是模块之间的通讯，bloc官方也给出了应对[方案](https://bloclibrary.dev/#/architecture?id=bloc-to-bloc-communication)。

// TODO: 更多内容

## 问题

作为个人对Bloc的首次实战，本项目还存在的很多问题待改善：

  * 复杂markdown内容的解析，比如：对他人发言的引用
  * 完善的错误处理
  * 缓存
  * 测试
  * UI细节
  * ...

// TODO：

## 版本规划

### v1.0.0

  * 首页即主题列表
  * 主题详情及快速回复
  * 搜索
  * 登录
  * 注册
  * 消息
  * 我的
  * 关于
  * 异常上报和运营统计(bugly)

### 后续版本需求

  * 推送
  * 优化快速回复UI
  * 帖子图片查看优化
  * 请求缓存
  * 独立的主题发布页
  * 主题、回复可编辑  
  * UI细节优化
  * 测试代码（非功能需求）

## 下载地址

Android apk: [Github releases](https://github.com/jarontai/dart-china/releases/)

iOS 应用商店地址: [Dart China](https://apps.apple.com/cn/app/id1574605471)

## 参考

以下是本项目实现所参考的文档、资料和博客等：

bloc官网：[bloclibrary.dev](https://bloclibrary.dev/)

油管视频教程：[The Best Flutter Bloc Complete Course](https://www.youtube.com/watch?v=THCkkQ-V1-8&t=314s)

mews技术博文：[one-year-in-production-with-flutter](https://developers.mews.com/one-year-in-production-with-flutter/)

Flutter项目生成工具: [very_good_cli](https://github.com/VeryGoodOpenSource/very_good_cli)
