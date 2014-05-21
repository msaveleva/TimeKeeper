//
//  UIColor+CustomColors.m
//  TimeKeeper
//
//  Created by Maria Saveleva on 21/05/14.
//  Copyright (c) 2014 Maria Saveleva. All rights reserved.
//

#import "UIColor+CustomColors.h"

@implementation UIColor (CustomColors)

+ (UIColor *)timeViewBackgroundColor
{
    //4daf7b
    return [UIColor colorWithRed:0x4d/255. green:0xaf/255. blue:0x7b/255. alpha:1];
}

+ (UIColor *)timeViewButtonsColor
{
    //49a675
    return [UIColor colorWithRed:0x49/255. green:0xa6/255. blue:0x75/255. alpha:1];
}

+ (UIColor *)headerViewBackground
{
    //f0e8e5
    return [UIColor colorWithRed:0xf0/255. green:0xe8/255. blue:0xe5/255. alpha:1];
}

@end
