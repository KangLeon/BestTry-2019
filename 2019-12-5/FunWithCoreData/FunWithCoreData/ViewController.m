//
//  ViewController.m
//  FunWithCoreData
//
//  Created by 吉腾蛟 on 2019/12/5.
//  Copyright © 2019 JY. All rights reserved.
//

/*
 NSManagedObjectContext 管理对象，上下文，持久性存储模型对象，处理数据与应用的交互
 NSManagedObjectModel 被管理的数据模型，数据结构
 NSPersistentStoreCoordinator 添加数据库，设置数据存储的名字，位置，存储方式
 NSManagedObject 被管理的数据记录
 NSFetchRequest 数据请求
 NSEntityDescription 表格实体结构

 
 */

#import "ViewController.h"
#import "Student+CoreDataClass.h"
#import "Student+CoreDataProperties.h"
#import "StudentTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(readonly,strong)NSPersistentContainer *persistentContainer;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@property (weak, nonatomic) IBOutlet UITableView *student_tableView;

@property(nonatomic,strong)NSMutableArray<Student *> *dataArray;

@property(nonatomic,strong)NSManagedObjectContext *context;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}
#pragma mark - 初始化UI

#pragma mark - 懒加载
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
#pragma mark - 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StudentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell_reuse_student"];
    [cell setContentWithStudentModel:[self.dataArray objectAtIndex:indexPath.row]];
    
    return cell;
}

//左滑删除
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        Student *student=[self.dataArray objectAtIndex:indexPath.row];
        //从数据库中删除内容
        [self delete:@[student]];
    }
}

#pragma mark - target action
- (IBAction)insert:(UIButton *)sender {
    Student *student=[self insert1];
    if (student!=nil) {
        [self.dataArray addObject:student];
        [self.student_tableView reloadData];
    }
}
- (IBAction)select:(UIButton *)sender {
    NSArray *students=[self search];
    if (students.count==0) {
        return;
    }
    
    //遍历
    [self.dataArray removeAllObjects];
    [students enumerateObjectsUsingBlock:^(Student * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.dataArray addObject:obj];
    }];
    
    [self.student_tableView reloadData];
}
- (IBAction)update:(UIButton *)sender {
    [self modify:self.dataArray];
}
- (IBAction)delateAll:(UIButton *)sender {
    [self delete:self.dataArray];
}

#pragma mark - Maonry

#pragma mark - other 只有本页面会使用的工具方法
-(Student *)insert{
    NSManagedObjectContext *context=self.persistentContainer.viewContext;
    NSError *error=nil;
    
    Student *student=[NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:context];
    
    student.name=[NSString stringWithFormat:@"学生-%d",arc4random()%100];
    student.age=arc4random()%20;
    student.sex=arc4random()%2==0 ? @"男" : @"女";
    student.height=arc4random()%100;
    student.number=arc4random()%100;
    
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@",error, error.userInfo);
        self.resultLabel.text=[NSString stringWithFormat:@"CoreData Error: %@",error.userInfo];
        abort();
        return nil;
    }else{
        self.resultLabel.text=@"插入数据成功";
    }
    
    return student;
}
-(Student *)insert1{
    NSError *error=nil;

    //开始创建托管对象，并指明好创建的托管对象d所属的实体名
    Student *student=[NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.context];
    
    //2.根据表Student中的键值，给NSManagedObject对象赋值
    student.name=[NSString stringWithFormat:@"学生-%d",arc4random()%100];
    student.age=arc4random()%20;
    student.sex=arc4random()%2==0 ? @"男" : @"女";
    student.height=arc4random()%180;
    student.number=arc4random()%100;
    
    if ([self.context hasChanges] && ![self.context save:&error]) {
     NSLog(@"Unresolved error %@, %@",error, error.userInfo);
         self.resultLabel.text=[NSString stringWithFormat:@"CoreData Error: %@",error.userInfo];
         abort();
         return nil;
     }else{
         self.resultLabel.text=@"插入数据成功";
     }
    
    return student;
}

-(NSArray *)search{
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Student"];
    
    //执行获取操作，获取所有Student托管对象
    NSError *error=nil;
    NSArray<Student *> *students=[self.context executeFetchRequest:request error:&error];
    
    if (error) {
        self.resultLabel.text=[NSString stringWithFormat:@"CoreData Error:%@",error.description];
    }else{
        self.resultLabel.text=@"查找数据成功";
    }
    
    return students;
}

-(void)delete:(NSArray *)delStudents{
    //获取数据的请求对象，指明对实体进行删除操作
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Student"];
    
    NSMutableArray *delStudentSuccess=[NSMutableArray array];//保存在数据库中成功被删除的对象
    [delStudents enumerateObjectsUsingBlock:^(Student * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //通过创建谓词对象，然后过滤掉符合要求的对象，也就是要删除的对象
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"number=%d",obj.number];
        request.predicate=predicate;
        
        //通过执行获取操作，找到要删除的对象即可
        NSError *error=nil;
        NSArray<Student *> *students=[self.context executeFetchRequest:request error:&error];
        
        //开始真正操作，一一遍历，遍历符合删除要求的对象数组，执行删除操作
        [students enumerateObjectsUsingBlock:^(Student * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.context deleteObject:obj];
        }];
        
        //错误处理
        if (error) {
            self.resultLabel.text=[NSString stringWithFormat:@"CoreData Error:%@",error.description];
        }else{
            [delStudentSuccess addObject:obj];
        }
    }];
    
    //最后保存数据，保存上下文
    if (self.context.hasChanges) {
        [self.context save:nil];
    }
    
    if (delStudentSuccess.count>0) {
        self.resultLabel.text=@"删除数据成功";
    }
    
    //将已经在数据库中被删除的对象从内存中移除
    [delStudentSuccess enumerateObjectsUsingBlock:^(Student * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.dataArray removeObject:obj];
    }];
    [self.student_tableView reloadData];
}

-(void)modify:(NSArray *)modifyStudents{
    //获取数据的请求对象，指明对实体进行删除操作
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Student"];
    
    NSMutableArray *modifyStudentSuccess=[NSMutableArray array];
    [modifyStudents enumerateObjectsUsingBlock:^(Student *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //通过创建谓词对象，然后过滤掉符合要求的对象，也就是要删除的对象
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"number=%d",obj.number];
        request.predicate=predicate;
        
        //通过执行获取操作，好到要删除的对象即可
        NSError *error=nil;
        NSArray<Student *> *students=[self.context executeFetchRequest:request error:&error];
        
        //开始真正操作，一一遍历，遍历符合删除要求的对象数组，执行删除操作
        [students enumerateObjectsUsingBlock:^(Student * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.age+=1;
            obj.sex=[obj.sex isEqualToString:@"男"] ? @"女" : @"男";
        }];
        
        //错误处理
        if (error) {
            self.resultLabel.text=[NSString stringWithFormat:@"CoreData Error:%@",error.description];
        }else{
            [modifyStudentSuccess addObject:obj];
        }
    }];
    
    //最后保存数据，保存上下文
    if (self.context.hasChanges) {
        [self.context save:nil];
    }
    
    if (modifyStudentSuccess.count>0) {
        self.resultLabel.text=@"修改数据成功";
    }
    
    NSArray *new=[self search];
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:new];
    [self.student_tableView reloadData];
    
    self.resultLabel.text=@"修改数据成功";
}

@synthesize persistentContainer = _persistentContainer;

-(NSPersistentContainer *)persistentContainer{
    @synchronized (self) {
        if (!_persistentContainer) {
            _persistentContainer=[[NSPersistentContainer alloc] initWithName:@"FunWithCoreData"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * _Nonnull storeDescription, NSError * _Nullable error) {
                if (error!=nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    return _persistentContainer;
}
-(NSManagedObjectContext *)context{
    if (!_context) {
        //创建上下文对象，并发队列设置为主队列
        _context=[[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        //创建托管对象模型，并使用Student.momd路径当作初始化参数
        //.xcdatamodeld文件编译之后变成.momd文件 （.mom文件）
        NSURL *modelPath=[[NSBundle mainBundle] URLForResource:@"FunWithCoreData" withExtension:@"momd"];
        NSManagedObjectModel *model=[[NSManagedObjectModel alloc] initWithContentsOfURL:modelPath];
        
        //创建持久化存储调度器
        NSPersistentStoreCoordinator *cordinate=[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        
        //创建并关联Sqlite数据库文件，如果已经存在则不会重复创建
        NSString *dataPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        dataPath=[dataPath stringByAppendingFormat:@"/%@.sqlite",@"Student"];
        
        [cordinate addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dataPath] options:nil error:nil];
        
        //上下文对象设置属性为持久化存储器
        _context.persistentStoreCoordinator=cordinate;
    }
    return _context;
}
@end
