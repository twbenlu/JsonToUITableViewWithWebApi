//
//  ViewController.m
//  7_UITableViewWithWebApi
//
//  Created by benlu on 2/25/15.
//  Copyright (c) 2015 benlu. All rights reserved.
//

#import "ViewController.h"
#import "myCell.h"
#import "object.h"

@interface ViewController ()
@end



@implementation ViewController

@synthesize info,Listobj;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    
    NSURL *url = [NSURL URLWithString:@"http://benluwebapi.azurewebsites.net/api/values"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    //取得Json資訊
    NSArray* jsonobj = [NSJSONSerialization JSONObjectWithData:data
                                                       options:NSJSONReadingMutableContainers
                                                         error:nil];
    //初始化Listobj物件
    Listobj = [[NSMutableArray alloc]init];
    
    //迭代出NSArray裡面的所有值，轉成物件後，存放到NSMutableArray裡面
    [jsonobj enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        NSDictionary* array1 = [jsonobj objectAtIndex:idx];
        RootObject *product = [[RootObject alloc] initWithDictionary:array1];
        [Listobj addObject:product];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return Listobj.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    RootObject *rootobject = [Listobj objectAtIndex:[indexPath row]];
     myCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil){
        cell = [[myCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //接著就可以用物件屬性的方式來操作物件
    
    cell.myLabel.text = rootobject.title;
    cell.myLabelDetail.text = rootobject.detail;
 
    //同步下載方式
//    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: rootobject.image]];
//    cell.myImage.image = [UIImage imageWithData:imageData];
    
    //非同步下載方式
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: rootobject.image]];
            if ( imageData == nil )
                return;
            dispatch_async(dispatch_get_main_queue(), ^{
                // WARNING: is the cell still using the same data by this point??
                cell.myImage.image = [UIImage imageWithData:imageData];
            });
        });
    
    return cell;
}





@end
