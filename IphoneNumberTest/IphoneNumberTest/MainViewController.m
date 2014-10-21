//
//  MainViewController.m
//  IphoneNumberTest
//
//  Created by sunlight on 14-9-12.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

#import "MainViewController.h"
#import <AddressBook/AddressBook.h>

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self genAddress];
    NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:@"SBFormattedPhoneNumber"];
    NSLog(@"%@",str);
    
}
//获取地址
- (void)genAddress{
    
    //未决定则提示用户选择(当前APP选择以后就不可以修改,删除再次下载也不会显示出来)
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined){
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            //如果用户点击了是
            if (granted) {
                ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
                CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
                if (results) {
                    [self parseAddress:results];
                    CFRelease(results);
                }
                CFRelease(addressBook);
            }
            
        });
        CFRelease(addressBook);
    }else{
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
        if (results) {
            [self parseAddress:results];
            CFRelease(results);
        }
        if (addressBook) {
            CFRelease(addressBook);
        }
    }
}

- (void)parseAddress:(CFArrayRef)results{

    for(int i = 0; i < CFArrayGetCount(results); i++){
        ABRecordRef person = CFArrayGetValueAtIndex(results, i);
        //读取firstname
        NSString *personName = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        NSLog(@"%@",personName);
        //读取lastname
        NSString *lastname = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
        NSLog(@"%@",lastname);
        //读取middlename
        NSString *middlename = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonMiddleNameProperty);
        NSLog(@"%@",middlename);
        //读取prefix前缀
        NSString *prefix = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonPrefixProperty);
        NSLog(@"%@",prefix);
        //读取suffix后缀
        NSString *suffix = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonSuffixProperty);
        NSLog(@"%@",suffix);
        //读取nickname呢称
        NSString *nickname = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonNicknameProperty);
        NSLog(@"%@",nickname);
        //读取firstname拼音音标
        NSString *firstnamePhonetic = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonFirstNamePhoneticProperty);
        NSLog(@"%@",firstnamePhonetic);
        //读取lastname拼音音标
        NSString *lastnamePhonetic = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonLastNamePhoneticProperty);
        NSLog(@"%@",lastnamePhonetic);
        //读取middlename拼音音标
        NSString *middlenamePhonetic = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonMiddleNamePhoneticProperty);
        NSLog(@"%@",middlenamePhonetic);
        //读取organization公司
        NSString *organization = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonOrganizationProperty);
        NSLog(@"%@",organization);
        //读取jobtitle工作
        NSString *jobtitle = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonJobTitleProperty);
        NSLog(@"%@",jobtitle);
        //读取department部门
        NSString *department = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonDepartmentProperty);
        NSLog(@"%@",department);
        //读取birthday生日
        NSDate *birthday = (__bridge_transfer NSDate*)ABRecordCopyValue(person, kABPersonBirthdayProperty);
        NSLog(@"%@",birthday);
        //读取note备忘录
        NSString *note = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonNoteProperty);
        NSLog(@"%@",note);
        //第一次添加该条记录的时间
        NSString *firstknow = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonCreationDateProperty);
        NSLog(@"%@",firstknow);
        //最后一次修改該条记录的时间
        NSString *lastknow = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonModificationDateProperty);
        NSLog(@"最后一次修改該条记录的时间%@\n",lastknow);
        //获取email多值
        ABMultiValueRef email = ABRecordCopyValue(person, kABPersonEmailProperty);
        int emailcount = ABMultiValueGetCount(email);
        for (int x = 0; x < emailcount; x++)
        {
            //获取CoreFoundation对象(需要释放)
            CFStringRef emailLabel = ABMultiValueCopyLabelAtIndex(email, x);
            //获取emailLabel 对象所有权转移给ARC进行管理
            NSString* localEmailLabel = (__bridge_transfer NSString*)ABAddressBookCopyLocalizedLabel(emailLabel);
            NSLog(@"%@",localEmailLabel);
            CFRelease(emailLabel);
            //获取email值 对象所有权转移给ARC进行管理
            NSString* emailContent = (__bridge_transfer NSString*)ABMultiValueCopyValueAtIndex(email, x);
            NSLog(@"%@",emailContent);
        }
        CFRelease(email);
        //读取地址多值
        ABMultiValueRef address = ABRecordCopyValue(person, kABPersonAddressProperty);
        int count = ABMultiValueGetCount(address);
        
        for(int j = 0; j < count; j++)
        {
            //获取地址Label
            CFStringRef addressLabel = ABMultiValueCopyLabelAtIndex(address, j);
            NSString *localAddressLabel = (__bridge_transfer NSString *)(ABAddressBookCopyLocalizedLabel(addressLabel));
            NSLog(@"%@",localAddressLabel);
            CFRelease(addressLabel);
            //获取該label下的地址6属性
            NSDictionary* personaddress =(__bridge_transfer NSDictionary*) ABMultiValueCopyValueAtIndex(address, j);
            NSString* country = [personaddress valueForKey:(NSString *)kABPersonAddressCountryKey];
            NSLog(@"%@",country);
            NSString* city = [personaddress valueForKey:(NSString *)kABPersonAddressCityKey];
            NSLog(@"%@",city);
            NSString* state = [personaddress valueForKey:(NSString *)kABPersonAddressStateKey];
            NSLog(@"%@",state);
            NSString* street = [personaddress valueForKey:(NSString *)kABPersonAddressStreetKey];
            NSLog(@"%@",street);
            NSString* zip = [personaddress valueForKey:(NSString *)kABPersonAddressZIPKey];
            NSLog(@"%@",zip);
            NSString* coutntrycode = [personaddress valueForKey:(NSString *)kABPersonAddressCountryCodeKey];
            NSLog(@"%@",coutntrycode);
        }
        CFRelease(address);
        //获取dates多值
        ABMultiValueRef dates = ABRecordCopyValue(person, kABPersonDateProperty);
        int datescount = ABMultiValueGetCount(dates);
        for (int y = 0; y < datescount; y++)
        {
            CFStringRef datesLabel = ABMultiValueCopyLabelAtIndex(dates, y);
            //获取dates Label
            NSString* localDatesLabel = (__bridge_transfer NSString*)ABAddressBookCopyLocalizedLabel(datesLabel);
            NSLog(@"%@",localDatesLabel);
            CFRelease(datesLabel);
            //获取dates值
            NSString* datesContent = (__bridge_transfer NSString*)ABMultiValueCopyValueAtIndex(dates, y);
            NSLog(@"%@",datesContent);
        }
        CFRelease(dates);
        //获取kind值
        CFNumberRef recordType = ABRecordCopyValue(person, kABPersonKindProperty);
        if (recordType == kABPersonKindOrganization) {
            // it's a company
            NSLog(@"it's a company\n");
        } else {
            // it's a person, resource, or room
            NSLog(@"it's a person, resource, or room\n");
        }
        CFRelease(recordType);
        //获取IM多值
        ABMultiValueRef instantMessage = ABRecordCopyValue(person, kABPersonInstantMessageProperty);
        for (int l = 1; l < ABMultiValueGetCount(instantMessage); l++)
        {
            //获取IM Label
            NSString* instantMessageLabel = (__bridge_transfer NSString*)ABMultiValueCopyLabelAtIndex(instantMessage, l);
            NSLog(@"%@",instantMessageLabel);
            //获取該label下的2属性
            NSDictionary* instantMessageContent =(__bridge_transfer NSDictionary*) ABMultiValueCopyValueAtIndex(instantMessage, l);
            NSString* username = [instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageUsernameKey];
            NSLog(@"%@",username);
            NSString* service = [instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageServiceKey];
            NSLog(@"%@",service);
        }
        CFRelease(instantMessage);
        
        //读取电话多值
        ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
        for (int k = 0; k<ABMultiValueGetCount(phone); k++)
        {
            CFStringRef personPhoneLabel = ABMultiValueCopyLabelAtIndex(phone, k);
            //获取电话Label
            NSString * localPersonPhoneLabel = (__bridge_transfer NSString*)ABAddressBookCopyLocalizedLabel(personPhoneLabel);
            NSLog(@"%@",localPersonPhoneLabel);
            CFRelease(personPhoneLabel);
            //获取該Label下的电话值
            NSString * personPhone = (__bridge_transfer NSString*)ABMultiValueCopyValueAtIndex(phone, k);
            NSLog(@"%@",personPhone);
        }
        CFRelease(phone);
        //获取URL多值
        ABMultiValueRef url = ABRecordCopyValue(person, kABPersonURLProperty);
        for (int m = 0; m < ABMultiValueGetCount(url); m++)
        {
            CFStringRef urlLabel = ABMultiValueCopyLabelAtIndex(url, m);
            //获取urlLabel
            NSString * localUrlLabel = (__bridge_transfer NSString*)ABAddressBookCopyLocalizedLabel(urlLabel);
            NSLog(@"%@",localUrlLabel);
            CFRelease(urlLabel);
            //获取該url下的电话值
            NSString * urlContent = (__bridge_transfer NSString*)ABMultiValueCopyValueAtIndex(url,m);
            NSLog(@"%@",urlContent);
        }
        CFRelease(url);
        //读取照片
        NSData *image = (__bridge_transfer NSData*)ABPersonCopyImageData(person);
        UIImageView *myImage = [[UIImageView alloc] initWithFrame:CGRectMake(200, 0, 50, 50)];
        [myImage setImage:[UIImage imageWithData:image]];
        myImage.opaque = YES;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
