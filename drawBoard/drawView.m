//
//  drawView.m
//  drawBoard
//
//  Created by rwli on 16/11/21.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import "drawView.h"
#import "LRWBezierPath.h"
#import "UIImageView+drawImage.h"
@interface drawView()
@property (strong,nonatomic)LRWBezierPath *path;
@property (assign,nonatomic)CGPoint cup;
@property (strong,nonatomic)NSMutableArray *pathArry;
@property (strong,nonatomic)UIImageView *imgv;
@end


@implementation drawView

-(void)awakeFromNib{
    self.size=1;
    self.color =[UIColor redColor];
}

-(void)drawRect:(CGRect)rect{
    
    for (LRWBezierPath *path in self.pathArry) {
        if ([path isKindOfClass:[UIImage class]]) {
            UIImage *img =(UIImage*)path;
            [img drawInRect:self.bounds];
        }
        else{
        [path.color setStroke];
            [path setLineJoinStyle:kCGLineJoinRound];
        [path stroke];
        }
    }
    
}
-(void)setColor:(UIColor *)color{
    _color=color;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    LRWBezierPath *path =[LRWBezierPath bezierPath];
    self.path=path;
    [self.pathArry addObject:path];
    self.cup =[[touches anyObject] locationInView:self];
    [self.path moveToPoint:self.cup];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.cup =[[touches anyObject] locationInView:self];
    [self.path addLineToPoint:self.cup];
    [self.path setColor:self.color];
    [self.path setLineWidth:self.size];
    [self setNeedsDisplay];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

-(NSMutableArray *)pathArry{
    if (!_pathArry) {
        _pathArry =@[].mutableCopy;
    }
    return _pathArry;
}
//顶部业务
-(void)clear{
    [self.pathArry removeAllObjects];
    [self setNeedsDisplay];
}

-(void)undo{
    [self.pathArry removeLastObject];
    [self setNeedsDisplay];
}
-(void)scratch{
    self.size=5;
    self.color=[UIColor whiteColor];
}
-(void)save{
    UIImage *img= [UIImageView image_cutwithrect:self.frame fromview:self];
    UIImageWriteToSavedPhotosAlbum(img, self, nil, nil);
}

-(void)selectFromBlum:(UIImage*)img{
    UIView *v =[[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:v];
    v.tag =-1024;
    v.backgroundColor=[UIColor greenColor];
    _imgv =[[UIImageView alloc]initWithFrame:v.bounds];
    _imgv.image=img;
    [v addSubview:_imgv];
    _imgv.userInteractionEnabled=YES;
    //添加手势
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    UIPinchGestureRecognizer *pin =[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pin:)];
    UILongPressGestureRecognizer *longp =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longp:)];
    UIRotationGestureRecognizer *totation =[[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rota:)];
    [_imgv addGestureRecognizer:pan];
    [_imgv addGestureRecognizer:pin];
    [_imgv addGestureRecognizer:longp];
    [_imgv addGestureRecognizer:totation];
}


//delegate  imgv
-(void)pan:(UIPanGestureRecognizer*)pan{
    self.cup =[pan translationInView:pan.view];
    _imgv.transform =CGAffineTransformTranslate( _imgv.transform, self.cup.x, self.cup.y);
    [pan setTranslation:CGPointZero inView:_imgv];
}

-(void)pin:(UIPinchGestureRecognizer*)pin{
    _imgv.transform =CGAffineTransformScale( _imgv.transform, pin.scale, pin.scale);
    [pin setScale:1];
}
-(void)longp:(UILongPressGestureRecognizer*)longp{
    if (longp.state ==UIGestureRecognizerStateBegan) {
    
    UIView *v =[self viewWithTag:-1024];
    [UIView animateWithDuration:0.5 animations:^{
        v.alpha=0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            v.alpha=1;
        } completion:^(BOOL finished) {
            //把截图添加到画版
            UIImage *img =[UIImageView image_cutwithrect:longp.view.frame fromview:v];
            [v removeFromSuperview];
            [self.pathArry addObject:img];
            [self setNeedsDisplay];
        }];
    }];
    }
}

-(void)rota:(UIRotationGestureRecognizer*)ro{
    ro.view.transform =CGAffineTransformRotate(ro.view.transform, ro.rotation);
    [ro setRotation:0];
    
}
@end
