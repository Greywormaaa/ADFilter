//
//  ADFilterDoubleMenuTableCell.h
//  ADFilter
//
//  Created by 马乾征 on 2017/9/15.
//  Copyright © 2017年 maqz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADFilterDoubleMenuTableCell : UITableViewCell
- (void)fillData:(id)data;
@end

@interface ADFilterDoubleMenuParentCell : ADFilterDoubleMenuTableCell

@end

@interface ADFilterDoubleMenuChildCell : ADFilterDoubleMenuTableCell

@end
