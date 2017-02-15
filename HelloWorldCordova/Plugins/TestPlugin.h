//
//  TestPlugin.h
//  HelloWorldCordova
//
//  Created by wangyatao on 17/2/7.
//
//

#import <Cordova/CDVPlugin.h>

@interface TestPlugin : CDVPlugin
-(void)testPluginFunction:(CDVInvokedUrlCommand *)command;
//参数传递 和回调
-(void)testPluginFunctionWithArgumentsAndCallBack:(CDVInvokedUrlCommand *)command;
@end
