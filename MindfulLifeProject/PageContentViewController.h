//
//  PageContentViewController.h
//  MindfulLifeProject
//
//  Created by Kerolos Nakhla on 12/9/15.
//  Copyright © 2015 Christopher Queen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController

@property NSUInteger pageIndex;
@property NSString *imageFile;

@property (weak, nonatomic) IBOutlet UIImageView *screenImage;

@end
