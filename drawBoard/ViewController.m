//
//  ViewController.m
//  drawBoard
//
//  Created by rwli on 16/11/21.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import "ViewController.h"
#import "drawView.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet drawView *deawview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)selectColor:(UIBarButtonItem *)sender {
    self.deawview.color=sender.tintColor;
}

- (IBAction)size:(UISlider *)sender {
    self.deawview.size=sender.value;
}

- (IBAction)deleAll:(UIBarButtonItem *)sender {
    [self.deawview clear];
}

- (IBAction)undo:(UIBarButtonItem *)sender {
    [self.deawview undo];
}

- (IBAction)crash:(UIBarButtonItem *)sender {
    [self.deawview scratch];
}

- (IBAction)selectPic:(UIBarButtonItem *)sender {
    
    UIImagePickerController *imgpick =[[UIImagePickerController alloc]init];
    imgpick.sourceType =UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imgpick.delegate=self;
    [self presentViewController:imgpick animated:YES completion:nil];
    
}

- (IBAction)saveDrawAsPic:(UIBarButtonItem *)sender {
    [self.deawview save];
}


//imgPick delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *img =info[UIImagePickerControllerOriginalImage];
    [self.deawview selectFromBlum:img];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


-(BOOL)prefersStatusBarHidden{
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
