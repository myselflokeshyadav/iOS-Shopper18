//
//  feedbackViewController.m
//  iOS-Shopper18
//
//  Created by Dustin Tong on 5/3/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "FeedbackViewController.h"
#import <SurveyMonkeyiOSSDK/SurveyMonkeyiOSSDK.h>

@interface FeedbackViewController ()<SMFeedbackDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) SMFeedbackViewController * feedbackController;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _feedbackController = [[SMFeedbackViewController alloc] initWithSurvey:@"2T37ZS7"];
    _feedbackController.delegate = self;
    [_feedbackController presentFromViewController:self animated:true completion:nil];
    // Do any additional setup after loading the view.
}
@end
