//
//  ViewController.m
//  sqlite
//
//  Created by MACbook2015 on 18/4/28.
//  Copyright © 2018年 MACbook2015. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>
@interface ViewController ()
@property (nonatomic) sqlite3 *shop;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    sqlite3* db = 0;
    NSString* filename=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"shop.sqlite"];
    
    int status=sqlite3_open(filename.UTF8String, &db);
    if(status == SQLITE_OK)//枚举值SQLITE_OK，代表成功的状态
    {
        NSLog(@"打开数据库成功");
        NSLog(@"%@",filename);
    }
    else
    {
        NSLog(@"打开数据库失败");
    }
    
    
    const char *sql = "create TABLE if not EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text, age integer);";
    char *errorMesg = NULL;
    int result = sqlite3_exec(db, sql, NULL,NULL, &errorMesg);
    if (result == SQLITE_OK) {
        NSLog(@"成功创建表XXX");
    }else{
        NSLog(@"创表失败：%s",errorMesg);
    }
    

const char *sql2 = "insert into t_student (name, age) values('jack', 20);";
char *errorMesg2 = NULL;
int result2 = sqlite3_exec(db,sql2,NULL, NULL, &errorMesg2);
if (result2 == SQLITE_OK) {
    NSLog(@"成功添加数据");
}else {
    NSLog(@"添加数据失败:%s",errorMesg);
}
    
    sqlite3_stmt *st=nil;
    char *sql_select= "SELECT name FROM t_student";
    
    if (sqlite3_prepare_v2(db, sql_select, -1, &st, NULL) != SQLITE_OK) {
        NSLog(@"Error: failed to prepare statement with message:get channels.");
    }
    
    while (sqlite3_step(st) == SQLITE_ROW)
    {
        char* name = (char*) sqlite3_column_text(st, 0);//第一列数据,注意此处师从0开始的
        NSString *nameNs=[[NSString alloc] initWithUTF8String:name];
        
        NSLog(@"%@",nameNs);
        
    }
    
    
    
    sqlite3_close(db);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
