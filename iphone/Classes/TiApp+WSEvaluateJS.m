/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2015年 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiApp+WSEvaluateJS.h"
#import "KrollBridge.h"
#import <objc/runtime.h>

@implementation TiApp (WSEvaluateJS)

-(void)setWs:(SRWebSocket *)ws
{
    objc_setAssociatedObject(self, @selector(ws), ws, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(SRWebSocket *)ws
{
    return objc_getAssociatedObject(self, @selector(ws));
}

-(id)init
{
    self = [super init];
    
    if (self != nil)
    {
        NSString *evaluateHost = [TiUtils stringValue:[[TiApp tiAppProperties] objectForKey:@"evaluate-host"]];
        if (evaluateHost != nil || ![evaluateHost isEqualToString:@""])
        {
            self.ws = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:evaluateHost]]];
            [self.ws setDelegate:self];
            [self.ws open];
        }
    }
    
    return self;
}

#pragma SocketRocket Delegate

-(void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    NSLog(@"webSocketDidOpen");
}

-(void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError");
    self.ws = nil;
}

-(void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean
{
    NSLog(@"didCloseWithCode");
    self.ws = nil;
}

-(void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    NSLog(@"didReceiveMessage");
    KrollBridge *bridge = [[TiApp app] krollBridge];
    [bridge evalJSWithoutResult:[TiUtils stringValue:message]];
    [self.ws send:message];
}

@end
