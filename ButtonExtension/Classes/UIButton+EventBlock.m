//
//  UIButton+EventBlock.m
//  FamilyMedicineBox
//
//  Created by luhua-mac on 2019/8/5.
//  Copyright © 2019 noKnow. All rights reserved.
//

#import "UIButton+EventBlock.h"
#import <objc/runtime.h>

static const void * _Nonnull key;
@implementation UIButton (EventBlock)

- (void)addBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block{
    
    NSString * methodName = [self eventName:controlEvents];
    NSMutableDictionary * oprations = (NSMutableDictionary*)objc_getAssociatedObject(self,  key);
    if (oprations==nil) {
        //初始化
        oprations = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, key, oprations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [oprations setValue:[block copy] forKey:methodName];
    [self addTarget:self action:NSSelectorFromString(methodName) forControlEvents:controlEvents];
}

-(NSString *)eventName:(UIControlEvents)event{
    if (event==UIControlEventTouchDown) {
        return @"UIControlEventTouchDown";
    }
    else if (event==UIControlEventTouchDownRepeat) {
        return @"UIControlEventTouchDownRepeat";
    }
    else if (event==UIControlEventTouchUpInside) {
        return @"UIControlEventTouchUpInside";
    }
    else if (event==UIControlEventTouchDragInside) {
        return @"UIControlEventTouchDragInside";
    }
    else if (event==UIControlEventTouchDragEnter) {
        return @"UIControlEventTouchDragEnter";
    }
    else if (event==UIControlEventTouchDragExit) {
        return @"UIControlEventTouchDragExit";
    }
    else if (event==UIControlEventTouchUpInside) {
        return @"UIControlEventTouchUpInside";
    }
    else if (event==UIControlEventTouchUpOutside) {
        return @"UIControlEventTouchUpOutside";
    }
    else if (event==UIControlEventTouchCancel) {
        return @"UIControlEventTouchCancel";
    }
    return nil;
}
/*
 UIControlEventTouchDown                                         = 1 <<  0,      // on all touch downs
 UIControlEventTouchDownRepeat                                   = 1 <<  1,      // on multiple touchdowns (tap count > 1)
 UIControlEventTouchDragInside                                   = 1 <<  2,
 UIControlEventTouchDragOutside                                  = 1 <<  3,
 UIControlEventTouchDragEnter                                    = 1 <<  4,
 UIControlEventTouchDragExit                                     = 1 <<  5,
 UIControlEventTouchUpInside                                     = 1 <<  6,
 UIControlEventTouchUpOutside                                    = 1 <<  7,
 UIControlEventTouchCancel
 
 */
-(void)UIControlEventTouchDown{
    [self callTargetBlock:UIControlEventTouchDown];
}
-(void)UIControlEventTouchDownRepeat{
    [self callTargetBlock:UIControlEventTouchDownRepeat];
}
-(void)UIControlEventTouchDragInside{
    [self callTargetBlock:UIControlEventTouchDragInside];
}
-(void)UIControlEventTouchDragOutside{
    [self callTargetBlock:UIControlEventTouchDragOutside];
}
-(void)UIControlEventTouchDragEnter{
    [self callTargetBlock:UIControlEventTouchDragEnter];
}
-(void)UIControlEventTouchDragExit{
    [self callTargetBlock:UIControlEventTouchDragExit];
}
-(void)UIControlEventTouchUpInside{
    [self callTargetBlock:UIControlEventTouchUpInside];
}

-(void)UIControlEventTouchUpOutside{
    [self callTargetBlock:UIControlEventTouchUpOutside];
}
-(void)UIControlEventTouchCancel{
    [self callTargetBlock:UIControlEventTouchCancel];
}

-(void)callTargetBlock:(UIControlEvents)event{
    NSString * methodName = [self eventName:event];
    NSMutableDictionary * oprations = (NSMutableDictionary*)objc_getAssociatedObject(self,  key);
    if(oprations ==nil){
        return;
    }
    void (^block)(id sender) = [oprations objectForKey:methodName];
    if (block) {
        block(self);
    }
}


@end
