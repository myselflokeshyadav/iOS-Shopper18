//
//  AccountViewController.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/7/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "AccountViewController.h"
#import <SurveyMonkeyiOSSDK/SurveyMonkeyiOSSDK.h>

@interface AccountViewController ()<SMFeedbackDelegate, UIAlertViewDelegate>

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Account";
}

- (IBAction)feedbackTapped:(id)sender {
    SMFeedbackViewController *vc = [[SMFeedbackViewController alloc] initWithSurvey:@"2T37ZS7"];
    vc.delegate = self;
    [vc presentFromViewController:self animated:YES completion:nil];
    
}

- (void)respondentDidEndSurvey:(SMRespondent *)respondent error:(NSError *)error{
    if(respondent != nil) {
        NSLog(@"cool");
    }
}

@end
