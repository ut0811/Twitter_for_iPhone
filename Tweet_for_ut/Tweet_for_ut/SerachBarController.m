//
//  SerachBarController.m
//  Tweet_for_ut
//
//  Created by YAMAMOTO Yuta on 2013/09/18.
//  Copyright (c) 2013年 yuta. All rights reserved.
//

#import "SerachBarController.h"

@implementation SerachBarController

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) searchItem:(NSString *) searchText {
    // 検索処理
}

- (void) searchBarSearchButtonClicked: (UISearchBar *) searchBar {
    [searchBar resignFirstResponder];
    [self searchItem:searchBar.text];
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *) searchText {
    NSLog(@"serch text=%@", searchText);
    if ([searchText length]!=0) {
        // インクリメンタル検索など
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
