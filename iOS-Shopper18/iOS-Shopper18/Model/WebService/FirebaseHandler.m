//
//  FirebaseHandler.m
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/5/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#import "FirebaseHandler.h"

@implementation FirebaseHandler

- (void)addProductToFirebase:(Product *)pInfo completion:(void(^)(id _Nullable, NSError * _Nullable))completion {
    
    self.ref = [[FIRDatabase database] reference];
    [[[self.ref child:@"users"] child:@"usersID"]
     setValue:@{@"username": @"test"}];
}

@end
