//
//  BusinessListVC.m
//  XXXXX XXXXXXX
//
//  Created by XXX XXXXX on 7/15/15.
//  Copyright (c) 2015 Inheritx Solutions Pvt. Ltd. All rights reserved.
//

#define APPNAME     @"XXX XXXXX"
#define APPFonts    @"Open Sans-Semibold"
#define DefaultProfileImageSize CGSizeMake(90, 90)
#define SCREEENWIDTH (self.view.frame.size.width>self.view.frame.size.height)?self.view.frame.size.width:self.view.frame.size.height

#import "BusinessListVC.h"
#import "CouponListVC.h"

@interface BusinessListVC ()
{
}
@end

@implementation BusinessListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [lblCategoryName setText:_strTitle];
}

#pragma mark - Table View Methods -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrBusinessList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellBusiness";
    CellCommon *cellBusiness = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    @try {
        [cellBusiness.lblCategory setText:[[_arrBusinessList objectAtIndex:indexPath.row] objectForKey:kbusiness_name]];
        [cellBusiness.imgCollegeImage setImageWithURL:[NSURL URLWithString:[[_arrBusinessList objectAtIndex:indexPath.row] objectForKey:kbusiness_logo]] placeholderImage:[UIImage imageNamed:@"circle_pla_hold"]];
        [cellBusiness.imgCollegeImage.layer setBorderColor:[ImageBoderColor CGColor]];

    }
    @catch (NSException *exception) {
        NSLog(@"Exception ERROR: %@",exception.description);
    }
    @finally {
    }

    [cellBusiness setSelectionStyle:UITableViewCellSelectionStyleNone];

    return cellBusiness;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [APPDELEGATE ShowHUDWith:@"Loading..."];
    NSDictionary *dataDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"coupon_list",kAction,[[_arrBusinessList objectAtIndex:indexPath.row] objectForKey:kbusiness_id],kbusiness_id,nil];
    NSString *URLString = [API_Local stringByAppendingString:WS_BusinessList];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:30.0];
    NSLog(@"URL %@ :: request %@ ",URLString, [dataDict JSONRepresentation]);
    [manager POST:URLString
       parameters:dataDict
          success:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 NSMutableDictionary *dictData = (NSMutableDictionary *)responseObject;
                 [SVProgressHUD dismiss];
                 
                 if ([[dictData objectForKey:kStatus] intValue] == 1) {
                     if ([dictData objectForKey:kData])
                     {
                         if ([[dictData objectForKey:kData] count] == 0) {
                             [UIAlertView showAlertViewWithTitle:APPNAME message:@"No coupons for selected Business!"];
                             return;
                         }
                         else
                         {
                             [self performSegueWithIdentifier:@"segueCouponList" sender:[NSDictionary dictionaryWithObjectsAndKeys:[_arrBusinessList objectAtIndex:indexPath.row],kBusinessDetails,[NSMutableArray arrayWithArray:[dictData objectForKey:kData]],kCouponList,nil]];
                         }
                     }
                 }
                 else
                 {
                     [UIAlertView showAlertViewWithTitle:APPNAME message:[dictData objectForKey:@"message"]];
                     
                 }
                 
                              }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
             {
                 [SVProgressHUD dismiss];
                 if ([error code] == -1009 || [error code] == -1003)
                 {
                     [Alerts showAlertWithMessage:@"Oops! Internet connection not available. Please try again later." withBlock:nil andButtons:@"Ok", nil];
                 }
                 else if ([error code] == -1001)
                 {
                     [UIAlertView showAlertViewWithTitle:APPNAME message:@"Request timed out! Please try again."];
                 }
                 else if ([error code] == -1005)
                 {
                     [UIAlertView showAlertViewWithTitle:APPNAME message:[[error userInfo] objectForKey:@"NSLocalizedDescription"]];
                 }
                 else
                 {
                     [UIAlertView showAlertViewWithTitle:APPNAME message:@"Some thing went wrong.Please try again!"];
                 }
             }
     ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    if ([segue.identifier isEqualToString:@"segueCouponList"]) {
        CouponListVC *objVCTemp = [segue destinationViewController];
        [ objVCTemp setDictData:(NSMutableDictionary *)sender];
    }
}


- (IBAction)actionBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
