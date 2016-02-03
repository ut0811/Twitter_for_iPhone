//
//  MyCellContentView.h
//  Tweet_for_ut
//
//  Created by yuta on 2013/09/15.
//  Copyright (c) 2013年 yuta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCellContentView : UIView

@property (copy, nonatomic) NSString *text;

// 初期化
+(id)cellContentView;

// labelText が収まるのに必要な高さを計算して返す
+(CGFloat)cellHeightWithText:(NSString*)labelText;

@end
