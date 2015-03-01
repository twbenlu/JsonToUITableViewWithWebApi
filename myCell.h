//
//  myCell.h
//  7_UITableViewWithWebApi
//
//  Created by benlu on 2/25/15.
//  Copyright (c) 2015 benlu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myCell : UITableViewCell

@property (weak, atomic) IBOutlet UIImageView *myImage;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UILabel *myLabelDetail;

@end
