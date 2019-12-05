//
//  AppDelegate.h
//  FunWithCoreData
//
//  Created by 吉腾蛟 on 2019/12/5.
//  Copyright © 2019 JY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

