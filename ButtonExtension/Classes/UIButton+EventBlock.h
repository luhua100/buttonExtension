//
//  UIButton+EventBlock.h
//  FamilyMedicineBox
//
//  Created by luhua-mac on 2019/8/5.
//  Copyright © 2019 noKnow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EventBlock)

- (void)addBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block;


@end


