//
//  UIImage+Barcode.m
//  MySam
//
//  Created by hanxiaozhu on 8/12/16.
//  Copyright © 2016 MySam. All rights reserved.
//

#import "UIImage+Barcode.h"

@implementation UIImage (Barcode)

/**
 *  生成条形码
 *  @param content 号码
 *  @param size    图片大小（如果条码的长度比较长，分辨率设置要高一些）
 *  @return 条形码图片
 */
+ (UIImage *)barcodeImageWithContent:(NSString *)content imageSize:(CGSize)size
{
    CIImage *image = [self barcodeImageWithContent:content];
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scaleWidth = size.width/CGRectGetWidth(extent);
    CGFloat scaleHeight = size.height/CGRectGetHeight(extent);
    size_t width = CGRectGetWidth(extent) * scaleWidth;
    size_t height = CGRectGetHeight(extent) * scaleHeight;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
    CGContextRef contentRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(contentRef, kCGInterpolationNone);
    CGContextScaleCTM(contentRef, scaleWidth, scaleHeight);
    CGContextDrawImage(contentRef, extent, imageRef);
    CGImageRef imageRefResized = CGBitmapContextCreateImage(contentRef);
    CGContextRelease(contentRef);
    CGImageRelease(imageRef);
    return [UIImage imageWithCGImage:imageRefResized];
}

/**
 *  原始的条形码
 *  @param content 号码
 *  @return 条形码原始图片
 */
+ (CIImage *)barcodeImageWithContent:(NSString *)content
{
    CIFilter *qrFilter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    [qrFilter setValue:contentData forKey:@"inputMessage"];
    [qrFilter setValue:@(0.00) forKey:@"inputQuietSpace"];
    CIImage *image = qrFilter.outputImage;
    return image;
}

@end
