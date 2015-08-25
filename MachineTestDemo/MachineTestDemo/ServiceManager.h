//
//  ServiceManager.h
//  MachineTestDemo
//
//  Created by Sachin Patil on 21/08/15.
//  Copyright (c) 2015 Sachin Patil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPRequest.h"
#import "ImageData.h"

@protocol ServiceManagerProtocol <NSObject>
-(void) serviceManagerOnResponseReceivedWithSuccess:(ImageData *) imageData;
-(void) serviceManagerOnResponseReceivedWithFailure:(NSError *) error;
@end

@interface ServiceManager : NSObject<HTTPRequestProtocol>

-(instancetype)initWithDelegate:(id<ServiceManagerProtocol>) delegate;

-(void) getImageDataWithResourcePath:(NSString *) resourcePath;

@end
