//
//  ViewController.h
//  7_UITableViewWithWebApi
//
//  Created by benlu on 2/25/15.
//  Copyright (c) 2015 benlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "object.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
//用來序列化Json的型別
@property (nonatomic)RootObject* info;
//動態陣列用來存放Json物件集合
@property (nonatomic) NSMutableArray *Listobj;
//UITableView
@property (nonatomic) IBOutlet UITableView* myTable;
@end

