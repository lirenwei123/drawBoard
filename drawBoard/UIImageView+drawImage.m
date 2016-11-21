//
//  UIImageView+drawImage.m
//  draw
//
//  Created by rwli on 16/11/19.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import "UIImageView+drawImage.h"


@implementation UIImageView (drawImage)


+(UIImage*)imageWithimg:(UIImage*)img  personalThing_path:(UIBezierPath*)BezierPath {
    UIGraphicsBeginImageContextWithOptions(img.size, NO, 0);
    [BezierPath addClip];
    [img drawAtPoint:CGPointZero];
    UIImage *myimg =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myimg;
    
}


//___以上为内部共用代码____________________________________________________//

+(UIImage*)roundImageWithimg:(UIImage*)img {
    UIBezierPath *path =[UIBezierPath  bezierPathWithOvalInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    return [UIImageView imageWithimg:img personalThing_path:path];
}

+(UIImage*)ovalImageWithimg:(UIImage*)img rectWfactor:(CGFloat)fctor_w rectHfactor:(CGFloat)fctor_h {
    UIBezierPath *path =[UIBezierPath  bezierPathWithOvalInRect:CGRectMake(0, 0, img.size.width*fctor_w, img.size.height*fctor_h)];
    return [UIImageView imageWithimg:img personalThing_path:path];
}

+(UIImage*)roundImageWithimg:(UIImage*)img borderWidth:(CGFloat)borderWidth borferColor:(UIColor*)color{
    CGSize size =CGSizeMake(img.size.width+2*borderWidth, img.size.height+2*borderWidth);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    UIBezierPath *path =[UIBezierPath  bezierPathWithOvalInRect:CGRectMake(0, 0, size.width,size.height)];
    [color set];
    [path fill];
    path =[UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, img.size.width, img.size.height)];
    [path addClip];
    
    [img drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    UIImage *myimg =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myimg;
}
+(UIImage*)ovalImageWithimg:(UIImage*)img borderWidth:(CGFloat)borderWidth borferColor:(UIColor*)color rectWfactor:(CGFloat)fctor_w rectHfactor:(CGFloat)fctor_h{
        CGSize size =CGSizeMake(img.size.width*fctor_w+2*borderWidth, img.size.height*fctor_h+2*borderWidth);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    UIBezierPath *path =[UIBezierPath  bezierPathWithOvalInRect:CGRectMake(0, 0, size.width,size.height)];
    [color set];
    [path fill];
    path =[UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, img.size.width*fctor_w, img.size.height*fctor_h)];
    [path addClip];
    
    [img drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    UIImage *myimg =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myimg;
}

+(UIImage*)imageWithimg:(UIImage*)img watermark:(NSString*)watermark attributeDic:(NSDictionary*)attributeDic watermarkdrawAtPoint:(CGPoint)point{
    UIGraphicsBeginImageContextWithOptions(img.size, NO, 0);
    [img drawAtPoint:CGPointZero];
    [watermark drawAtPoint:point withAttributes:attributeDic];
    UIImage *myimg =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myimg;
}
+(void)image:(UIImage*)img savetofile:(NSString*)filepath imageformat:(NSString*)JPEG_PNG{
    NSData *data;
    if ([JPEG_PNG isEqualToString:@"JPEG"])  {
        data =UIImageJPEGRepresentation(img, 1);
    }else{
        data =UIImagePNGRepresentation(img);
    }
    [data writeToFile:filepath atomically:YES];
    
}

+(void)imageWithview:(UIView*)view  savepath:(NSString*)path imageformat:(NSString*)JPEG_PNG{
    UIImage *img =[UIImageView imageWithview:view];
    [UIImageView image:img savetofile:path imageformat:JPEG_PNG];
}

+(UIImage*)imageWithview:(UIView*)view  {
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0);
    CGContextRef ctx=  UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage *img= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
+(void)image_cutwithrect:(CGRect)rect fromimgv:(UIImageView*)imgv{
    imgv.image =[UIImageView image_cutwithrect:rect fromview:imgv];
}

+(UIImage*)image_cutwithrect:(CGRect)rect fromview:(UIView*)view{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0);
    UIBezierPath *path =[UIBezierPath bezierPathWithRect:rect];
    [path addClip];
    //裁剪之后再去渲染
    CGContextRef ctx =UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+(UIImage*)image_cutwithOval_rect:(CGRect)rect fromview:(UIView*)view{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0);
    UIBezierPath *path =[UIBezierPath bezierPathWithOvalInRect:rect];
    [path addClip];
    //裁剪之后再去渲染
    CGContextRef ctx =UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}




























@end
