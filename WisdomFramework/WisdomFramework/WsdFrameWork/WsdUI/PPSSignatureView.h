#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

//开源签名视图，画笔根据速率的快慢而粗细
@interface PPSSignatureView : GLKView

@property (assign, nonatomic) BOOL hasSignature;
@property (strong, nonatomic) UIImage *signatureImage;

- (void)erase;

@end
