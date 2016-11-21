//
//  UIImageView+drawImage.h
//  draw
//
//  Created by rwli on 16/11/19.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (drawImage)

//内部通用的代码块
+(UIImage*)imageWithimg:(UIImage*)img  personalThing_path:(UIBezierPath*)BezierPath;


//圆形的图片
+(UIImage*)roundImageWithimg:(UIImage*)img;
//椭圆的图片 fctor_w ：图片依原始宽比例0-1； fctor_h：图片依原始高比例0-1；
+(UIImage*)ovalImageWithimg:(UIImage*)img rectWfactor:(CGFloat)fctor_w rectHfactor:(CGFloat)fctor_h;

//带边框的圆形图片，
+(UIImage*)roundImageWithimg:(UIImage*)img borderWidth:(CGFloat)borderWidth borferColor:(UIColor*)color;
//带边框的椭圆形图片，
+(UIImage*)ovalImageWithimg:(UIImage*)img borderWidth:(CGFloat)borderWidth borferColor:(UIColor*)color rectWfactor:(CGFloat)fctor_w rectHfactor:(CGFloat)fctor_h;

//带水印的原始矩形图片
+(UIImage*)imageWithimg:(UIImage*)img watermark:(NSString*)watermark attributeDic:(NSDictionary*)attributeDic watermarkdrawAtPoint:(CGPoint)point;
//保存img到文件，
+(void)image:(UIImage*)img savetofile:(NSString*)filepath imageformat:(NSString*)JPEG_PNG;
//截取一个view的图片，JPEG_PNG：JPEG/PNG格式
+(void)imageWithview:(UIView*)view  savepath:(NSString*)path imageformat:(NSString*)JPEG_PNG;
//截取一个view
+(UIImage*)imageWithview:(UIView*)view ;
//从imgv中裁剪rect大小的图片,给imgv重新设置新图片
+(void)image_cutwithrect:(CGRect)rect fromimgv:(UIImageView*)imgv;
//从view中裁剪出rect大小的img，返回img；
+(UIImage*)image_cutwithrect:(CGRect)rect fromview:(UIView*)view;
//从view中裁剪出圆/椭圆的img，返回img；
+(UIImage*)image_cutwithOval_rect:(CGRect)rect fromview:(UIView*)view;

@end
