//
//  YCContactsController.m
//  YouChat
//
//  Created by Kowloon on 15/7/16.
//  Copyright (c) 2015年 Goome. All rights reserved.
//

#import "YCContactsController.h"
#import "YCAddFriendController.h"
#import "YCChatDetailController.h"
@interface YCContactsController ()<NSFetchedResultsControllerDelegate, YCAddFriendControllerDelegate>

@property(nonatomic, strong)NSFetchedResultsController *fetchedResult;

@end

@implementation YCContactsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = YC_TitleOfContacts;
    [self loadPeople];
    
    [self rightItemOfAddFriendsImplementation];
}
- (void)rightItemOfAddFriendsImplementation
{
    UIImage *rightImage = [UIImage imageNamed:@"contacts_add_friend"];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(addFriends)];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)addFriends
{
    YCLog(@"addFriends");
    YCAddFriendController *add = [[YCAddFriendController alloc] init];
    add.delegate = self;
    [self.navigationController pushViewController:add animated:YES];
}
- (void)loadPeople
{
    NSManagedObjectContext *context = [YCXMPPTool sharedYCXMPPTool].rosterStorage.mainThreadManagedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPUserCoreDataStorageObject"];
//    NSString *jid = [YCUserInfo sharedYCUserInfo].jid;
    //排序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"displayName" ascending:YES];
    request.sortDescriptors = @[sort];
    self.fetchedResult = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResult.delegate = self;
    NSError *err = nil;
    [self.fetchedResult performFetch:&err];
    if (err) YCLog(@"%@",err);

}
#pragma mark 当数据的内容发生改变后，会调用 这个方法
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    YCLog(@"数据发生改变");
    //刷新表格
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.fetchedResult.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"ContactCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    // 获取对应好友
    //XMPPUserCoreDataStorageObject *friend =self.friends[indexPath.row];
    XMPPUserCoreDataStorageObject *friend = self.fetchedResult.fetchedObjects[indexPath.row];
    //    sectionNum
    //    “0”- 在线
    //    “1”- 离开
    //    “2”- 离线
    switch ([friend.sectionNum intValue]) {//好友状态
        case 0:
            cell.detailTextLabel.text = @"在线";
            break;
        case 1:
            cell.detailTextLabel.text = @"离开";
            break;
        case 2:
            cell.detailTextLabel.text = @"离线";
            break;
        default:
            break;
    }
    cell.textLabel.text = friend.jidStr;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    XMPPUserCoreDataStorageObject *friend = self.fetchedResult.fetchedObjects[indexPath.row];
    YCChatDetailController *chatDetail = [[YCChatDetailController alloc] init];
    chatDetail.myFriend = friend;
    [self.navigationController pushViewController:chatDetail animated:YES];
}


//实现这个方法，cell往左滑就会有个delete
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        YCLog(@"删除好友");
        XMPPUserCoreDataStorageObject *friend = self.fetchedResult.fetchedObjects[indexPath.row];
        
        XMPPJID *freindJid = friend.jid;
        [[YCXMPPTool sharedYCXMPPTool].roster removeUser:freindJid];
    }
}
#pragma mark - YCAddFriendControllerDelegate
- (void)addFriendController:(YCAddFriendController *)addFriendController didAddUser:(NSString *)user
{
    YCLog(@"%@",user);
    NSString *jidStr = [NSString stringWithFormat:@"%@@%@",user,[YCUserInfo sharedYCUserInfo].domain];
    XMPPJID *friendJid = [XMPPJID jidWithString:jidStr];
    [[YCXMPPTool sharedYCXMPPTool].roster subscribePresenceToUser:friendJid];
}

- (void)dealloc
{
    YCLog(@"%@ -> dealloc", NSStringFromClass([self class]));
}


@end








