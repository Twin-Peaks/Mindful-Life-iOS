//
//  PageContentViewController.m
//  MindfulLifeProject
//
//  Created by Kerolos Nakhla on 12/9/15.
//  Copyright © 2015 Christopher Queen. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.screenImage.image = [UIImage imageNamed:self.imageFile];
    
}


@end
