//
//  MyCellContentView.m
//  Tweet_for_ut
//
//  Created by yuta on 2013/09/15.
//  Copyright (c) 2013年 yuta. All rights reserved.
//

#import "MyCellContentView.h"
#import "BALabel.h" // BaseAppKit の UILabel のサブクラス、べんり

@interface MyCellContentView ()

// xib と接続しているラベル
@property (weak, nonatomic) IBOutlet BALabel *textLabel;

@end

#pragma mark -

@implementation MyCellContentView

static CGFloat _standardCellHeight;
static CGRect _standardLabelRect;
static UILineBreakMode _labelLineBreakMode;
static UIFont *_labelFont;

// クラスがロードされたときに呼ばれるメソッド. 複数回呼ばれることもあり得るので注意
+ (void)initialize
{
    [super initialize];
    
    // 念のため、MyCellContentView がロードされたときのみとしておく。+initialize が複数回呼ばれる事もあるらしい
    if (self == [MyCellContentView class])
    {
        // セルの高さを計算する際に使う値をスタティック変数に持っておく
        MyCellContentView *view = [MyCellContentView cellContentView];
        
        _standardCellHeight = CGRectGetHeight(view.frame); // xib の時点でのセルの高さ. 基本これが最小値
        _standardLabelRect = view.textLabel.frame; // xib の時点でのラベルの frame
        _labelLineBreakMode = view.textLabel.lineBreakMode; // xib の時点でのラベルの LineBreakMode
        _labelFont = view.textLabel.font; // xib の時点でのラベルのフォント
    }
}

// nib(xib)ファイルがロードされたときに呼ばれる
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // BALabelのBAVerticalAlignmentTopは文字列を上寄りにできて便利
    self.textLabel.verticalAlignment = BAVerticalAlignmentTop;
    self.text = self.text; // 念のため値を更新する
}

+ (id)cellContentView
{
    // xib から初期化する
    UINib *nib = [UINib nibWithNibName:@"MyCellContentView" bundle:nil];
    return [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
}

// 文字列が収まるのに必要な高さを計算して返すクラスメソッド
+ (CGFloat)cellHeightWithText:(NSString*)labelText
{
    if (!labelText || labelText.length == 0) return _standardCellHeight;
    
    
    // クラスロード時に保持していた各値を使って計算
    // 文字列が描画される矩形の大きさを取得
    // 横幅は固定しているが、iPad 等で横幅も指定する必要あるなら、ここで行う
    CGSize size = [labelText sizeWithFont:_labelFont
                        constrainedToSize:CGSizeMake(_standardLabelRect.size.width, 1000)
                            lineBreakMode:_labelLineBreakMode];
    
    // 余白とか
    CGFloat margin = fabs(_standardCellHeight - CGRectGetHeight(_standardLabelRect));
    CGFloat cellHeight;
    cellHeight = size.height + margin;
    
    // 計算した高さが最小値を下回っていたら無理矢理最小値に補正
    if (cellHeight < _standardCellHeight) return _standardCellHeight;
    
    return cellHeight;
}

#pragma mark -

// textプロパティのセッターを上書き
// textが設定されると同時に、ラベルにも反映させる
- (void)setText:(NSString *)text
{
    _text = [text copy];
    
    // ラベルに値を反映
    [self.textLabel setText:text];
}

@end
