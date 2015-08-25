//
//  ResponseParser.m
//  MachineTestDemo
//
//  Created by Sachin Patil on 21/08/15.
//  Copyright (c) 2015 Sachin Patil. All rights reserved.
//

#import "ResponseParser.h"
#import "ImageCategoryData.h"
#import "ImageInfo.h"

@implementation ResponseParser
{
    ImageData *imageData;
}

- (instancetype)initWithResponseData:(id) responseData
{
    self = [super init];
    if (self) {
        if(responseData != nil){
            [self parseResponseData:responseData];
        }
    }
    return self;
}

-(void) parseResponseData:(id) responseData
{
    NSDictionary *responseDict = (NSDictionary *) responseData;
    NSMutableArray *allImagesArr = [[NSMutableArray alloc] initWithCapacity:1];
    NSMutableArray *allCategoryArr = [[NSMutableArray alloc] initWithCapacity:1];
    for(NSString *key in responseDict.allKeys){
        NSMutableArray *allImageInfoArr = [[NSMutableArray alloc] initWithCapacity:1];
        ImageCategoryData *categoryData = [[ImageCategoryData alloc]init];
        categoryData.categoryName = key;
        
        NSArray *imageArray = [responseDict objectForKey:key];
        for(NSDictionary *categoryDict in imageArray){
            NSString *imageName = [categoryDict objectForKey:@"name"];
            NSString *imgUrl = [categoryDict objectForKey:@"imgURL"];
            
            ImageInfo *imgInfo = [[ImageInfo alloc] init];
            imgInfo.imageName = imageName;
            imgInfo.imageURL = imgUrl;
            
            [allImageInfoArr addObject:imgInfo];
        }
        categoryData.allImageInfo = allImageInfoArr;
        [allCategoryArr addObject:categoryData];
    }
    [allImagesArr addObject:allCategoryArr];
    
    imageData = [[ImageData alloc] init];
    imageData.allImageData = allCategoryArr;
}

-(ImageData *)getAllImageData
{
    return imageData;
}

@end
