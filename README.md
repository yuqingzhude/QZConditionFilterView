# ConditionFilterViewDemo

如果觉得下面的很乱 懒得看  直接看ViewController.m使用实例也行


TableView条件筛选，类淘宝“销量最高”，“综合排序”
- 目前只支持三个筛选框，还没有通用框架，如果只要两个，可以直接不加第三个，调整frame即可，如果是四个的话只能自己手动再加

相似存储数组参数解释：

QZConditionFilterView.h

/** 外部传入对应三个下拉tableView的DataSource*/

@property (nonatomic,strong) NSArray *dataAry1;

@property (nonatomic,strong) NSArray *dataAry2;

@property (nonatomic,strong) NSArray *dataAry3;

// 暂时为无用变量，用于内部设置默认数据 [1] [2] [3] 现在情况比较简单，外部赋初值

@property (nonatomic,strong) NSArray *sortTitleAry;

QZConditionFilterView.m

// 存储 tableView didSelected数据 数据来源：FilterDataTableView

NSArray *_dataSource1;

NSArray *_dataSource2;

NSArray *_dataSource3;

ViewController.m

// *存储* 网络请求url中的筛选项 数据来源：View中_dataSource1或者一开始手动的初值

NSArray *_selectedDataSource1Ary;

NSArray *_selectedDataSource2Ary;

NSArray *_selectedDataSource3Ary;
