//
//  ToolHeader.h
//  NewInformationEnter
//
//  Created by sunlight on 14-4-11.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#ifndef NewInformationEnter_ToolHeader_h
#define NewInformationEnter_ToolHeader_h

//数据库操作结果枚举
typedef enum DBResult{
    DBResultSuccess,
    DBResultDataHasExists,
    DBResultDataNotExists,
    DBResultOpenDatabaseFailure

}DBResult;

//定义常量
#define WSD_NUMBERS @"0123456789"
#define WSD_DOUBLE_NUMBERS @"0123456789."
#define WSD_ZERO @"0"
#define WSD_DECIMAL_POINT @"."

#endif
