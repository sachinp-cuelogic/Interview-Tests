//
//  ViewController.h
//  MachineTestDemo
//
//  Created by Sachin Patil on 21/08/15.
//  Copyright (c) 2015 Sachin Patil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceManager.h"
#import "GalleryTableViewCell.h"
#import "ImageCategoryData.h"


@interface ViewController : UIViewController<ServiceManagerProtocol,GalleryTableViewCellProtocol>
{
    __weak IBOutlet UITableView *tblView;
    __weak IBOutlet UIImageView *imageView;
}

@end

