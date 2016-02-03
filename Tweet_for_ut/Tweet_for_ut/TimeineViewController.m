//
//  TimeineViewController.m
//  Tweet_for_ut
//
//  Created by yuta on 2013/09/14.
//  Copyright (c) 2013年 yuta. All rights reserved.
//

#import "TimeineViewController.h"
#import "ViewController.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>



@interface TimeineViewController ()

@end

@implementation TimeineViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
	ACAccountType *twitterAccountType
    = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:twitterAccountType
                            withCompletionHandler:^(BOOL granted, NSError *error)
     {
         if (!granted) {
             NSLog(@"ユーザーがアクセスを拒否しました。");
         }else{
             NSArray *twitterAccounts
             = [accountStore accountsWithAccountType:twitterAccountType];
             if ([twitterAccounts count] > 0) {
                 ACAccount *account = [twitterAccounts objectAtIndex:0];
                 NSURL *url
                 = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/home_timeline.json"];
                 TWRequest *request = [[TWRequest alloc] initWithURL:url
                                                          parameters:nil
                                                       requestMethod:TWRequestMethodGET];
                 [request setAccount:account];
                 [request performRequestWithHandler:
                  ^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
                  {
                      if(!responseData){
                          NSLog(@"%@", error);
                      }else{
                          NSError* error;
                          statuses = [NSJSONSerialization JSONObjectWithData:responseData
                                                                     options:NSJSONReadingMutableLeaves
                                                                       error:&error];
                          NSLog(@"%@", statuses);
                          if(statuses){
                              dispatch_async(dispatch_get_main_queue(), ^{ // 追加
                                  [self.tableView reloadData]; // 追加
                              }); // 追加
                          }else{
                              NSLog(@"%@", error);
                          }
                      }
                  }];
             }
         }
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [statuses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if(cell == nil){ // 追加
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle // 追加
                                      reuseIdentifier:CellIdentifier]; // 追加
        cell.textLabel.font = [UIFont systemFontOfSize:8.0]; // 追加
        cell.detailTextLabel.numberOfLines = 0;
        cell.textLabel.numberOfLines = 1;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:10.0];
    } // 追加
    NSDictionary *status = [statuses objectAtIndex:indexPath.row];
    //NSLog(@"%@",status);
    NSDictionary *user = [status objectForKey:@"user"];
    NSString *text = [status objectForKey:@"text"]; //
    
    NSString *name = [user objectForKey:@"screen_name"];
    NSString *idName = [user objectForKey:@"name"];
    NSString *a = [idName stringByAppendingString:@"\t@"];
    NSString *tweetUser = [a stringByAppendingString:name];


    //NSString *className = NSStringFromClass([[status objectForKey:@"user"] class]);デバッグ用
    NSString *imageUrl = [user objectForKey:@"profile_image_url"];//URLを取得

    NSURL *myURL = [NSURL URLWithString:imageUrl];
    NSData * myData = [NSData dataWithContentsOfURL:myURL];
    UIImage *myImage = [UIImage imageWithData:myData];
    cell.imageView.image = myImage;//TLのプロフィール画像表示
    cell.detailTextLabel.text = text;
    cell.textLabel.text = tweetUser; // テキスト表示
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)pressComposeButton:(id)sender {
    if([TWTweetComposeViewController canSendTweet]){            // ツイートできるかどうかをチェックする
        TWTweetComposeViewController *composeViewController     //
        = [[TWTweetComposeViewController alloc] init];          // TWTweetComposeViewControllerオブジェクトを作成する
        [self presentModalViewController:composeViewController  //
                                animated:YES];                  // TWTweetComposeViewControllerオブジェクトを表示する
    }                                                           //
}

- (IBAction)refreshButton:(id)sender {
    [self viewDidLoad];
}

- (CGFloat)getCellHeight:(UITableView *)tableView cell:(UITableViewCell *)cell {
    CGSize bounds = CGSizeMake(255, tableView.frame.size.height);
    CGSize size = [cell.textLabel.text sizeWithFont:cell.textLabel.font
                                  constrainedToSize:bounds
                                      lineBreakMode:UILineBreakModeCharacterWrap];
    return size.height + 50.0;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return [self getCellHeight:tableView cell:cell];
}



@end
