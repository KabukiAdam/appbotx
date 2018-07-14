//
//  ABXFont.h
//  Sample Project
//
//  Created by Adam Shaw on 7/14/18.
//  Copyright © 2018 Appbot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ABXFont : NSObject

+ (void)setFontName:(NSString*)fontName;
+ (UIFont*)fontWithSize:(CGFloat)size;

@end
