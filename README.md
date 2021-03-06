[![CocoaPods](https://cocoapod-badges.herokuapp.com/v/CHNetworking/badge.svg)](http://www.cocoapods.org/?q=CHNetworking)
![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)
![Platform info](http://img.shields.io/cocoapods/p/CHNetworking.svg?style=flat)

# CHNetworking的介绍
基于 AFNetworking 3.0.4 版本 封装的 iOS 网络请求库，实现了对象请求的设计思想 ,把每一个Request当成一个对象来处理.
 1.   [CHNetworking安装](https://github.com/chausson/CHNetworking#安装)
 2.   [CHNetworking提供的功能](https://github.com/chausson/CHNetworking#提供的功能) 
 3.   [CHNetworking的基础](https://github.com/chausson/CHNetworking#CHNetworking的基础)  
 4.   [益处](https://github.com/chausson/CHNetworking#这样的益处)  
 5.   [弊端](https://github.com/chausson/CHNetworking#它的弊端)
 6.   [CHNetworking设计架构图](https://github.com/chausson/CHNetworking#CHNetworking设计架构图)

# CHNetworking安装

```
pod 'CHNetworking'

```

# CHNetworking提供的功能
理想的实现功能是这些
一.方便调试
二.全局配置
三.API简化
四.复用性
五.解耦
六.复用
七.解析
八.缓存
九.Toast
十.扩展性

## 目前实现的功能
```
相比 AFNetworking，CHNetworking 提供了以下的功能：  支持按不同类型切换网络环境 支持 block 模式的回调方式

1.支持批量的网络请求发送，并统一设置它们的回调（以后实现）

2.支持方便地设置有相互依赖的网络请求的发送，例如：发送请求A，根据请求A的结果，选择性的发送请求B和C，再根据B和C的结果，选择性的发送请求D。（以后实现） 

3.支持网络请求 基础参数设计，可以统一为网络请求加上一些参数，或者修改一些路径。

4.支持自定义用户体验提示，在请求的时候开始HUD提示，或者在失败的时候提示用户。 

5.支持自动释放block，不用关心block的循环引用
```

# CHNetworking的基础
把每一个网络请求封装成一个对象，每一个请求都需要继承CHRequest类，子类实现父类的方法来构造请求。  

# 这样的益处
将网络请求与具体的第三方库依赖隔离，方便以后更换底层的网络库。 
方便在基类中处理公共逻辑。 方便复用请求对象。 
方便做对象的持久化。 

# 它的弊端
也是相对的在整个项目中增加了对网络请求的代码量和文件类的增加。

# CHNetworking设计架构图
 ![image](https://github.com/chausson/CHNetworking/blob/master/CHNetworkingDesgin.png)
   
