//
//  MindfulCheckinViewController.h
//  MindfulLifeProject
//
//  Created by Kerolos Nakhla on 12/9/15.
//  Copyright © 2015 Christopher Queen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface MindfulCheckinViewController : UIViewController <UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *PageViewController;
@property (nonatomic, strong) NSArray *arrayPageImages;

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index;



@end
