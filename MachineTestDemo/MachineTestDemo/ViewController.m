//
//  ViewController.m
//  MachineTestDemo
//
//  Created by Sachin Patil on 21/08/15.
//  Copyright (c) 2015 Sachin Patil. All rights reserved.
//

#import "ViewController.h"
#import "Constant.h"

#define URL_PATH @"/imageData.php"

@interface ViewController ()

@end

@implementation ViewController
{
    NSArray *allImageData;
    GalleryTableViewCell *protoTypeCell;
}

#pragma mark -
#pragma mark ==============================
#pragma mark View Life cycle
#pragma mark ==============================


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.clipsToBounds = YES;
    
    [self loadAllGalleryImages];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark ==============================
#pragma mark Status Bar
#pragma mark ==============================

-(void) setStatusBarHidden
{
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    }
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark -
#pragma mark ==============================
#pragma mark Private Functions
#pragma mark ==============================

-(void) loadAllGalleryImages
{
    ServiceManager *serviceManager = [[ServiceManager alloc] initWithDelegate:self];
    [serviceManager getImageDataWithResourcePath:[NSString stringWithFormat:@"%@%@",SERVER_URL,URL_PATH]];
}

#pragma mark -
#pragma mark ==============================
#pragma mark PrototypeCell
#pragma mark ==============================

- (GalleryTableViewCell *)protoTypeCell
{
    if (!protoTypeCell) {
        protoTypeCell = [tblView dequeueReusableCellWithIdentifier:@"GalleryTableViewCell"];
    }
    return protoTypeCell;
}


- (void)configureCell:(GalleryTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    DebugLog(@"");
    ImageCategoryData *categorydata = allImageData[indexPath.section];
    NSArray *arrImgs = categorydata.allImageInfo;
    cell.delegate = self;
    [cell addImages:arrImgs];
    
}

#pragma mark -
#pragma mark ==============================
#pragma mark Service Manger delagates
#pragma mark ==============================

-(void) serviceManagerOnResponseReceivedWithSuccess:(ImageData *)imageData
{
    DebugLog(@"");
    if(imageData != nil){
        allImageData = imageData.allImageData;
        [tblView reloadData];
    }
}

-(void) serviceManagerOnResponseReceivedWithFailure:(NSError *)error
{
    DebugLog(@"");
}

#pragma mark -
#pragma mark ==============================
#pragma mark Gallery Protocol
#pragma mark ==============================

-(void) galleryTableViewOnImageSelected:(ImageInfo *)imageInfo
{
    DebugLog(@"");
    NSURL *imgURL = [NSURL URLWithString: [NSString stringWithFormat:@"%@/%@", SERVER_URL,imageInfo.imageURL] ];
    [imageView setImageWithURL:imgURL];
}

#pragma mark -
#pragma mark ==============================
#pragma mark TableViewDelegates
#pragma mark ==============================

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    DebugLog(@"");
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    DebugLog(@"");
    return allImageData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DebugLog(@"");
    DebugLog(@"Row: %ld",(long)indexPath.row);
    GalleryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GalleryTableViewCell"];
    cell.clipsToBounds =YES;
    [self configureCell:cell forRowAtIndexPath:indexPath];
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    DebugLog(@"");
    ImageCategoryData *categorydata = allImageData[section];
    NSString *categoryName = [categorydata.categoryName capitalizedString];
    return categoryName;
}

@end
