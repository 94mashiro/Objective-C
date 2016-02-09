//
//  DetailViewController.m
//  Homepwner
//
//  Created by Shiina Mashiro on 16/2/4.
//  Copyright © 2016年 Shiina Mashiro. All rights reserved.
//

#import "DetailViewController.h"
#import "BNRItem.h"
#import "ImageStore.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *trashButton;

@end

@implementation DetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    BNRItem *item = self.item;
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    // BRONZE CHALLENGE - DISPLAY A NUMBERPAD FOR THE VALUE FIELD
    self.valueField.keyboardType = UIKeyboardTypeNumberPad;
    
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    // 当从ItemViewController中选中某行进入DetailViewController时也要从ImageStore中提取出对应Key的照片
    NSString *itemKey = self.item.itemKey;
    UIImage *imageToDisplay = [[ImageStore sharedStore] imageForKey:itemKey];
    self.imageView.image = imageToDisplay;
    // SILVER CHALLENGE - FIX BUG 加一个对trashButton是否可用的判断
    if ([[ImageStore sharedStore] imageForKey:self.item.itemKey] != nil) {
        self.trashButton.enabled = YES;
    } else {
        self.trashButton.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 取消当前的第一响应对象，可以代替resignFirstResponder
    [self.view endEditing:YES];
    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

- (void)setItem:(BNRItem *)item {
    // 不能在init方法中设置标题的原因是，这时候item属性还没有赋值，是nil
    _item = item;
    self.navigationItem.title = _item.itemName;
}
// SILVER CHALLENGE - DISMISSING A NUMBER PAD
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    // BRONZE CHALLENGE - EDITING AN IMAGE
    imagePicker.allowsEditing = YES;
    // 首先检查设备是否支持相机功能
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // 设置为新拍摄一张相片
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        // 设置为从照片库中选取一张相片
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    // 将委托设置为自身
    imagePicker.delegate = self;
    // 以模态的形式显示UIImagePickerController对象，该视图会占据整个屏幕
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // 获取info字典里选择或者拍摄的照片
//    UIImage *image = info[UIImagePickerControllerOriginalImage];
    // BRONZE CHALLENGE - STEP 2
    UIImage *image = info[UIImagePickerControllerEditedImage];
    // 将照片存入ImageStore中
    [[ImageStore sharedStore] setImage:image forKey:self.item.itemKey];
    self.imageView.image = image;
    self.trashButton.enabled = YES;
    // 设置完毕后 关闭该对象
    [self dismissViewControllerAnimated:YES completion:nil];
}


// 当textField按下return的时候需要关闭键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)clearPicture:(id)sender {
    [[ImageStore sharedStore] deleteImageForKey:self.item.itemKey];
    self.imageView.image = nil;
    self.trashButton.enabled = NO;
}


// 添加摄像功能，同时可用摄像或者拍照功能

//- (IBAction)takePicture:(id)sender {
//    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
//    NSArray *availableTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
//    ipc.mediaTypes = availableTypes;
//    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
//    ipc.delegate = self;
//    [self presentViewController:ipc animated:YES completion:nil];
//}
//
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//    NSURL *mediaURL = info[UIImagePickerControllerMediaURL];
//    NSLog(@"%@",mediaURL);
//    // 2016-02-09 21:23:17.341 Homepwner[7521:1949250] file:///private/var/mobile/Containers/Data/Application/7DD0DE6B-21E8-46E8-905D-C790F9F4AAE2/tmp/capture/capturedvideo.MOV GET URL
//}



@end
