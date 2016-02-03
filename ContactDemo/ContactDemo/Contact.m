//
//  Contact.m
//  ContactDemo
//
//  Created by Shiina Mashiro on 15/10/12.
//  Copyright © 2015年 Shiina Mashiro. All rights reserved.
//

#import "Contact.h"

@implementation Contact

-(Contact *)initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName andPhoneNumber:(NSString *)phoneNumber {
    if (self=[super init]) {
        self.firstName = firstName;
        self.lastName = lastName;
        self.phoneNumber = phoneNumber;
    }
    return self;
}

-(NSString *)getName {
    return [NSString stringWithFormat:@"%@ %@",_lastName ,_firstName];
}

+(Contact *)initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName andPhoneNumber:(NSString *)phoneNumber {
    Contact *contact1 = [[Contact alloc] initWithFirstName:firstName andLastName:lastName andPhoneNumber:phoneNumber];
    return contact1;
}

@end
