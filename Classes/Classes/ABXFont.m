//
//  ABXFont.m
//  Sample Project
//
//  Created by Adam Shaw on 7/14/18.
//  Copyright © 2018 Appbot. All rights reserved.
//

#import "ABXFont.h"

static UIFont *_abxCustomFont = nil;

@implementation ABXFont

+ (void)setFontName:(NSString*)fontName {
    _abxCustomFont = [UIFont fontWithName:fontName size:15.0];
}

+ (UIFont*)fontWithSize:(CGFloat)size {
    if (_abxCustomFont) {
        return [_abxCustomFont fontWithSize:size];
    }
    else {
        return [UIFont systemFontOfSize:size];
    }
}

@end
