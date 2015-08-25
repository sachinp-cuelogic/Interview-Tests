//  MachineTestDemo
//
//  Created by Sachin Patil on 21/08/15.
//  Copyright (c) 2015 Sachin Patil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@protocol HTTPRequestProtocol <NSObject>
-(void) httpRequestOnResponseReceivedWithSuccess:(id) response;
-(void) httpRequestOnResponseReceivedWithFailure:(NSError *) error;
@end

@interface HTTPRequest : NSObject

-(instancetype)initWithDelegate:(id<HTTPRequestProtocol>) delegate;

-(void) sendHttpRequestWithResourcePath:(NSString *) resourcePath ;

@end
