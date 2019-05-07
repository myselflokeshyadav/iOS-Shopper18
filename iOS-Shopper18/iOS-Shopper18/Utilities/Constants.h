//
//  Constants.h
//  iOS-Shopper18
//
//  Created by Alvin Ling on 5/2/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

//  User Defaults
#define kUserDefaultsMobile     @"savedUserMobile"
#define kUserDefaultsPassword   @"savedUserPassword"
#define kUserDefaultsUserInfo   @"savedUser"

//  Colors
#define kColorPrimeGreen        [UIColor.new initWithDisplayP3Red:79/255.0 green:175/255.0 blue:95/255.0 alpha:1]
#define kColorPrimeOrange       [UIColor.alloc initWithDisplayP3Red:224/255.0 green:163/255.0 blue:71/255.0 alpha:1];

//  API
//  Ecommerce Endpoints
#define kAPIEcomBase            @"http://rjtmobile.com/aamir/e-commerce/ios-app/"

#define kAPIEndPointRegister    @"shop_reg.php?"
#define kAPIEndPointLogin       @"shop_login.php?"
#define kAPIEndPointProfile     @"edit_profile.php?"
#define kAPIEndPointPassw       @"shop_reset_pass.php?"
#define kAPIEndPointForgot      @"forgot_pass_email.php?"
#define kAPIEndPointMakeOrder   @"orders.php?"
#define kAPIEndPointOrderHist   @"order_history.php?"
#define kAPIEndPointShipTrack   @"shipment_track.php?"
#define kAPIEndPointCoupon      @"coupon.php?"
#define kAPIEndPointProfPic     @"profile_pic_upload.php?"
#define kAPIEndPointTopSellers  @"shop_top_sellers.php?"

//  Shopping Cart Endpoints
#define kAPICartBase            @"http://rjtmobile.com/ansari/shopingcart/ios-ssl/"

#define kAPIEndPointCategory    @"cust_category.php?"
#define kAPIEndPointSubCategory @"cust_sub_category.php?"
#define kAPIEndPointProductList @"product_details.php?"

//  API Testing
#define kTestAPIKey             @"93331a060929e7db1a3d1383fe604db8"
#define kTestUserID             @"1745"
#define kTestMobile             @"4444444444"
#define kTestPassword           @"asdf1234"

//  Messages
#define kUnknownOrderStatus     @"Order status undefined"


//  Braintree Token
#define kclientToken @"eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiIzNGYzNmU2NGM5YzA5YzFiNzkwYzg1ZjdiZjQwZGM5YzFlZWVkM2EzOTAyZTQ3NzA1MWZmNDY5NmE4MmNkZmIyfGNyZWF0ZWRfYXQ9MjAxOS0wNS0wNVQwMDoyNjowMC4yNDk4MjgxOTIrMDAwMFx1MDAyNm1lcmNoYW50X2lkPXJqZnpwNHRzejh5ajhrejJcdTAwMjZwdWJsaWNfa2V5PTYybjUzdHJoNnAzOXBxeWIiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvcmpmenA0dHN6OHlqOGt6Mi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJncmFwaFFMIjp7InVybCI6Imh0dHBzOi8vcGF5bWVudHMuc2FuZGJveC5icmFpbnRyZWUtYXBpLmNvbS9ncmFwaHFsIiwiZGF0ZSI6IjIwMTgtMDUtMDgifSwiY2hhbGxlbmdlcyI6W10sImVudmlyb25tZW50Ijoic2FuZGJveCIsImNsaWVudEFwaVVybCI6Imh0dHBzOi8vYXBpLnNhbmRib3guYnJhaW50cmVlZ2F0ZXdheS5jb206NDQzL21lcmNoYW50cy9yamZ6cDR0c3o4eWo4a3oyL2NsaWVudF9hcGkiLCJhc3NldHNVcmwiOiJodHRwczovL2Fzc2V0cy5icmFpbnRyZWVnYXRld2F5LmNvbSIsImF1dGhVcmwiOiJodHRwczovL2F1dGgudmVubW8uc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbSIsImFuYWx5dGljcyI6eyJ1cmwiOiJodHRwczovL29yaWdpbi1hbmFseXRpY3Mtc2FuZC5zYW5kYm94LmJyYWludHJlZS1hcGkuY29tL3JqZnpwNHRzejh5ajhrejIifSwidGhyZWVEU2VjdXJlRW5hYmxlZCI6dHJ1ZSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwicGF5cGFsIjp7ImRpc3BsYXlOYW1lIjoiYnJhaW50cmVlIiwiY2xpZW50SWQiOm51bGwsInByaXZhY3lVcmwiOiJodHRwOi8vZXhhbXBsZS5jb20vcHAiLCJ1c2VyQWdyZWVtZW50VXJsIjoiaHR0cDovL2V4YW1wbGUuY29tL3RvcyIsImJhc2VVcmwiOiJodHRwczovL2Fzc2V0cy5icmFpbnRyZWVnYXRld2F5LmNvbSIsImFzc2V0c1VybCI6Imh0dHBzOi8vY2hlY2tvdXQucGF5cGFsLmNvbSIsImRpcmVjdEJhc2VVcmwiOm51bGwsImFsbG93SHR0cCI6dHJ1ZSwiZW52aXJvbm1lbnROb05ldHdvcmsiOnRydWUsImVudmlyb25tZW50Ijoib2ZmbGluZSIsInVudmV0dGVkTWVyY2hhbnQiOmZhbHNlLCJicmFpbnRyZWVDbGllbnRJZCI6Im1hc3RlcmNsaWVudDMiLCJiaWxsaW5nQWdyZWVtZW50c0VuYWJsZWQiOnRydWUsIm1lcmNoYW50QWNjb3VudElkIjoiYnJhaW50cmVlIiwiY3VycmVuY3lJc29Db2RlIjoiVVNEIn0sIm1lcmNoYW50SWQiOiJyamZ6cDR0c3o4eWo4a3oyIiwidmVubW8iOiJvZmYifQ=="

#endif /* Constants_h */
