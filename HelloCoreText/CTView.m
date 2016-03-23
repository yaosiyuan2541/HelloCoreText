//
//  CTView.m
//  HelloCoreText
//
//  Created by 姚思远 on 16/2/17.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "CTView.h"

@implementation CTView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //创建一个带有属性的字符串，可以修改文本样式，现在暂时先用一个单纯的字符串，后面我们将会对其进行修改
    NSMutableAttributedString * attString = [[NSMutableAttributedString alloc]initWithString:@"Hello Core Text"];
    
//     long number = 10;
//     CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
//     [attString addAttribute:(id)kCTCharacterShapeAttributeName value:(__bridge id)num range:NSMakeRange(0, 4)];
    
    /*
     //设置字体属性
     CTFontRef font = CTFontCreateWithName(CFSTR("Georgia"), 40, NULL);
     [attString addAttribute:(id)kCTFontAttributeName value:(__bridge id)font range:NSMakeRange(0, 5)];
    */
    /*
     //设置字体简隔 eg:test
     long number = 10;
     CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
     [attString addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(10, 4)];
     */
    
    /*
     long number = 1;
     CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
     [attString addAttribute:(id)kCTLigatureAttributeName value:(__bridge id)num range:NSMakeRange(0, [attString length])];
    */
    /*
     //设置字体颜色
     [attString addAttribute:(id)kCTForegroundColorAttributeName value:(id)[UIColor redColor].CGColor range:NSMakeRange(0, 9)];
     */
    /*
     //设置字体颜色为前影色
     CFBooleanRef flag = kCFBooleanTrue;
     [attString addAttribute:(id)kCTForegroundColorFromContextAttributeName value:(id)flag range:NSMakeRange(5, 10)];
     */
    
    /*
     //设置空心字
     long number = 2;
     CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
     [attString addAttribute:(id)kCTStrokeWidthAttributeName value:(__bridge id)num range:NSMakeRange(0, [attString length])];
     
     //设置空心字颜色
     [attString addAttribute:(id)kCTStrokeColorAttributeName value:(id)[UIColor redColor].CGColor range:NSMakeRange(0, [attString length])];
    
    */
    /*
     long number = 1;
     CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
     [attString addAttribute:(id)kCTSuperscriptAttributeName value:(id)num range:NSMakeRange(3, 1)];
     */
    
    /*
     //设置斜体字
     CTFontRef font = CTFontCreateWithName((CFStringRef)[UIFont italicSystemFontOfSize:20].fontName, 40, NULL);
     [attString addAttribute:(id)kCTFontAttributeName value:(__bridge id)font range:NSMakeRange(0, 5)];
     */
    
    /*
     //下划线
     [attString addAttribute:(id)kCTUnderlineStyleAttributeName value:(id)[NSNumber numberWithInt:kCTUnderlineStyleSingle] range:NSMakeRange(0, 5)];
     //下划线颜色
     [attString addAttribute:(id)kCTUnderlineColorAttributeName value:(id)[UIColor redColor].CGColor range:NSMakeRange(0, 5)];
     //字体颜色
    [attString addAttribute:(id)kCTForegroundColorAttributeName value:(id)[UIColor redColor].CGColor range:NSMakeRange(0, 5)];
    */
    
    
    
    //对同一段字体进行多属性设置
    //红色
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithObject:(id)[UIColor redColor].CGColor forKey:(id)kCTForegroundColorAttributeName];
    //斜体
    CTFontRef font = CTFontCreateWithName((CFStringRef)[UIFont italicSystemFontOfSize:20].fontName, 40, NULL);
    [attributes setObject:(__bridge id)font forKey:(id)kCTFontAttributeName];
    //下划线
    [attributes setObject:(id)[NSNumber numberWithInt:kCTUnderlineStyleSingle] forKey:(id)kCTUnderlineStyleAttributeName];
    [attString addAttributes:attributes range:NSMakeRange(0, 5)];

    [attString endEditing];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //获取一个用于绘制的路径区域
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    //通过属性化文本attString创建一个frameSetter，frameSetter主要是用来管理CoreText中的字体引用和文本绘制的
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    //通过当前的属性化文本，大概估算出当前CoreText需要的画布有多大
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, [attString length]), path, NULL);
    //此时，运行程序以后会看到模拟器中有一个倒着的HelloCoreText，这是为什么呢？
    //主要原因就在于我们常用的UIKit框架下面的布局是x右y下，而在coretext中则是x右y上，所以我们在使用coreText进行文本绘制是要记得现将我们的坐标系以x轴为准向上翻转
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    //注意：一定要在绘制之前翻转坐标系，否则就不起作用了
    CTFrameDraw(frame, context);
    
    
}
@end
