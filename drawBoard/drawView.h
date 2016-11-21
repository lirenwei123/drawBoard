//
//  drawView.h
//  drawBoard
//
//  Created by rwli on 16/11/21.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface drawView : UIView
@property (assign,nonatomic)CGFloat size;
@property (strong,nonatomic)UIColor *color;

-(void)clear;
-(void)undo;
-(void)scratch;
-(void)selectFromBlum:(UIImage*)img;
-(void)save;

@end
