//
//  ServiceManager.m
//  MachineTestDemo
//
//  Created by Sachin Patil on 21/08/15.
//  Copyright (c) 2015 Sachin Patil. All rights reserved.
//

#import "ServiceManager.h"
#import "ResponseParser.h"

@implementation ServiceManager
{
    id<ServiceManagerProtocol> del;
}

-(instancetype)initWithDelegate:(id<ServiceManagerProtocol>) delegate
{
    self = [super init];
    if (self) {
        del = delegate;
    }
    return self;
}

-(void) getImageDataWithResourcePath:(NSString *) resourcePath
{
    HTTPRequest *request = [[HTTPRequest alloc] initWithDelegate:self];
    [request sendHttpRequestWithResourcePath:resourcePath];
}

#pragma mark -
#pragma mark ==============================
#pragma mark HTTPRequest Protocol
#pragma mark ==============================

-(void) httpRequestOnResponseReceivedWithSuccess:(id)response
{
    if(response != nil){
        ResponseParser *parser = [[ResponseParser alloc] initWithResponseData:response];
        ImageData *imgData = [parser getAllImageData];
        if(imgData != nil){
            [del serviceManagerOnResponseReceivedWithSuccess:imgData];
        }else{
            [del serviceManagerOnResponseReceivedWithFailure:nil];
        }
    }
}

-(void) httpRequestOnResponseReceivedWithFailure:(NSError *)error
{
    [del serviceManagerOnResponseReceivedWithFailure:nil];
}

@end
