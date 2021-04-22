//
//  UIImage+Barcode.h
//  MySam
//
//  Created by hanxiaozhu on 8/12/16.
//  Copyright © 2016 MySam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Barcode)

/**
 *  生成条形码
 *  @param content 号码
 *  @param size    图片大小（如果条码的长度比较长，分辨率设置要高一些）
 *  @return 条形码图片
 */
+ (UIImage *)barcodeImageWithContent:(NSString *)content imageSize:(CGSize)size;

@end
