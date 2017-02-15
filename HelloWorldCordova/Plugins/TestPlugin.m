//
//  TestPlugin.m
//  HelloWorldCordova
//
//  Created by wangyatao on 17/2/7.
//
//

#import "TestPlugin.h"

@interface TestPlugin()
@property(nonatomic,strong) NSString *callbackId;
@end

@implementation TestPlugin

-(void)testPluginFunction:(CDVInvokedUrlCommand *)command{
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"OC弹框" message:@"testPluginFunction" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *aa = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [ac addAction:aa];
    [self.viewController presentViewController:ac animated:YES completion:nil];
}

-(void)testPluginFunctionWithArgumentsAndCallBack:(CDVInvokedUrlCommand *)command{
    
    //***CDVInvokedUrlCommand的四个成员变量，
    NSString *callbackId = command.callbackId;
    NSString *className = command.className;
    NSString *methodName = command.methodName;
    NSArray *arguments = command.arguments;
    NSLog(@"callbackId:%@",callbackId);
    NSLog(@"className:%@",className);
    NSLog(@"methodName:%@",methodName);
    NSLog(@"arguments:%@",arguments);
    
    //***打印传入的参数
    NSString *argumentsStr = @"";
    for (NSDictionary *dict in command.arguments) {
        for (NSString *key in dict.allKeys) {
            NSObject *object = [dict objectForKey:key];
            if ([object isKindOfClass:[NSString class]]) {
                argumentsStr = [NSString stringWithFormat:@"%@%@=%@\n",argumentsStr,key,object];
            } else if([object isKindOfClass:[NSArray class]]){
                argumentsStr = [NSString stringWithFormat:@"%@%@:\n",argumentsStr,key];
                for (NSObject *subObject in (NSArray *)object) {
                    if ([subObject isKindOfClass:[NSString class]]) {
                        argumentsStr = [NSString stringWithFormat:@"%@%@\n",argumentsStr,subObject];
                    }
                }
            }
        }
    }
    
    self.callbackId = command.callbackId;
    [self alertMessage:argumentsStr andTitle:@"OC弹框"];
}

//弹出提示信息
-(void)alertMessage:(NSString *)message andTitle:(NSString *)title{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *aaYES = [UIAlertAction actionWithTitle:@"成功" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //***回调JS方法
        NSArray *array = @[@"返回参数1", @"返回参数2"];
        //CDVPluginResult 的status属性是只读属性，初始化方法“resultWithStatus: messageAsArray:”的第一个参数传入CDVCommandStatus_OK时，调用js的成功回调方法，传入其他的值都执行js的失败回调方法
        //回调js的成功回调方法
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:array];
        [self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
    }];
    
    UIAlertAction *aaNO = [UIAlertAction actionWithTitle:@"失败" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //***回调JS方法
        NSArray *array = @[@"返回参数1", @"返回参数2"];
        //CDVPluginResult 的status属性是只读属性，初始化方法“resultWithStatus: messageAsArray:”的第一个参数传入CDVCommandStatus_OK时，调用js的成功回调方法，传入其他的值都执行js的失败回调方法
        //回调js的失败回调方法
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsArray:array];
        [self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
    }];
    
    [ac addAction:aaYES];
    [ac addAction:aaNO];
    [self.viewController presentViewController:ac animated:YES completion:nil];
}


@end
