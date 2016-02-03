//
//  TimeineViewController.h
//  Tweet_for_ut
//
//  Created by yuta on 2013/09/14.
//  Copyright (c) 2013年 yuta. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TimeineViewController : UITableViewController{
    NSArray *statuses;
}
@property (nonatomic, retain) UILabel *title;
- (IBAction)pressComposeButton:(id)sender;
- (IBAction)refreshButton:(id)sender;
@end
