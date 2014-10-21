//
//  YDTextView.m
//  YDReader
//
//  Created by sunlight on 14-10-13.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "YDTextView.h"

@interface YDTextView()

@property (strong,nonatomic) NSDictionary *textDic;
@property (assign,nonatomic) NSInteger pageCount;
@property (assign,nonatomic) float totalHeight;

@end

@implementation YDTextView

-(instancetype)initWithFrame:(CGRect)frame{
    
    //IOS7创建UITextView  防止滚动卡
    NSTextStorage *textStorage = [[NSTextStorage alloc] init];
    NSLayoutManager *layoutManage = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManage];
    NSTextContainer *container = [[NSTextContainer alloc] initWithSize:frame.size];
    [layoutManage addTextContainer:container];
    self = [super initWithFrame:frame textContainer:container];
    if (self) {
        
    }
    return self;
}


//重写setText,处理数据分页
-(void)setText:(NSString *)text{
    [super setText:text];
    //处理text
    [self parseText];
}
- (void)setFont:(UIFont *)font{
    [super setFont:font];
    //[self parseText];
}



//解析处理Text
- (void)parseText{
    if (self.text!=nil && ![self.text isEqualToString:@""]) {
        //获取总高度
        CGRect rect = [self.text boundingRectWithSize:self.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil];
        //获取总页数
        double totalHeight = rect.size.height;
        double pageHeight = self.bounds.size.height;
        
        int pageCount = totalHeight/pageHeight;
        //float求余
        if (fmod(totalHeight, pageHeight) > 0) {
            pageCount++;
        }
        NSInteger textLength = self.text.length;
        self.pageCount = pageCount;
        NSMutableDictionary *textDic = [[NSMutableDictionary alloc] init];
        NSInteger location = 0;
        NSInteger length = 100;
        for (int i = 0 ; i < self.pageCount ; i++) {
            NSMutableString *onePageText = [[NSMutableString alloc] init];
            float height;
            do {
                NSRange range = {location,length};
                if (range.location+range.length > textLength-1) {
                    length = textLength-1-range.location;
                }
                NSString *text = [self.text substringWithRange:range];
                [onePageText appendString:text];
                CGRect rect = [onePageText boundingRectWithSize:CGSizeMake(self.width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil];
                height = [onePageText boundingRectWithSize:CGSizeMake(self.width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size.height;
                length +=100;
            } while (height < pageHeight);
            location += length;
            length = 100;
            [textDic setObject:onePageText forKey:@(i)];
        }
        self.totalHeight = totalHeight;
    }
}

//当前页文字
- (NSString *)currentPageText{
    
    return [self.textDic objectForKey:[NSNumber numberWithInteger:[self currentPageNum]]];
    
}

//当前第几页
- (NSInteger)currentPageNum{
    //当前高度
    float currentHeight = self.contentOffset.y;
    NSInteger pageNum = currentHeight/self.bounds.size.height;
    if(fmod(currentHeight, self.bounds.size.height)>0){
        pageNum ++;
    }
    return pageNum;
}

//总页数
- (NSInteger)totalPageCount{
    return self.pageCount;
}

//当前阅读百分比(0-1)
- (float) currentPercent{
    if (self.totalHeight == 0) {
        return 0;
    }
    return self.contentOffset.x/self.totalHeight;
}


@end
