//
//  ResponseParser.h
//  MachineTestDemo
//
//  Created by Sachin Patil on 21/08/15.
//  Copyright (c) 2015 Sachin Patil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageData.h"

@interface ResponseParser : NSObject
-(instancetype) initWithResponseData:(id) responseData;
-(ImageData *)getAllImageData;
@end
