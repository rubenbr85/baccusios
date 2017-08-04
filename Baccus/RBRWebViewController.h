//
//  RBRWebViewController.h
//  Baccus
//
//  Created by Ruben Berreguero on 03/09/13.
//  Copyright (c) 2013 Ruben Berreguero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBRWineModel.h"

@interface RBRWebViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) RBRWineModel *model;
@property (weak, nonatomic) IBOutlet UIWebView *browser;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;


-(id) initWithModel: (RBRWineModel *)aModel;

@end
