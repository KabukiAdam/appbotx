//
//  ABXPromptView.h
//  Sample Project
//
//  Created by Stuart Hall on 30/05/2014.
//  Copyright (c) 2014 Appbot. All rights reserved.
//

@import UIKit;

@protocol ABXPromptViewDelegate <NSObject>

- (void)appbotPromptForReview;
- (void)appbotPromptForFeedback;
- (void)appbotPromptClose;

@end

@interface ABXPromptView : UIView

@property (weak) id<ABXPromptViewDelegate> delegate;

+ (BOOL)hasHadInteractionForCurrentVersion;

@end

