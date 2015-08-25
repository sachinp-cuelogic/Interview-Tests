//  MachineTestDemo
//
//  Created by Sachin Patil on 21/08/15.
//  Copyright (c) 2015 Sachin Patil. All rights reserved.
//

#import "HTTPRequest.h"
#import "JSON.h"

@implementation HTTPRequest
{
    id<HTTPRequestProtocol> reqDelegate;
}

#pragma mark -
#pragma mark ==============================
#pragma mark Init
#pragma mark ==============================

-(instancetype)initWithDelegate:(id<HTTPRequestProtocol>) delegate
{
    self = [super init];
    if (self) {
        reqDelegate = delegate;
    }
    return self;
}

#pragma mark -
#pragma mark ==============================
#pragma mark Public Functions
#pragma mark ==============================

-(void) sendHttpRequestWithResourcePath:(NSString *) resourcePath
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    
 
    [manager GET:resourcePath parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [reqDelegate httpRequestOnResponseReceivedWithSuccess:responseObject];
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [reqDelegate httpRequestOnResponseReceivedWithFailure:error];
     }];

}

@end

