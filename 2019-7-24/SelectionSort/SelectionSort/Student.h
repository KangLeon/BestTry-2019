//
//  Student.h
//  SelectionSort
//
//  Created by 吉腾蛟 on 2019/7/24.
//  Copyright © 2019 JY. All rights reserved.
//

#ifndef Student_h
#define Student_h

#include<iostream>
#include<string>

using namespace std;

struct Student {
    string name;
    int score;
    
    //小于号的重载
    bool operator<(const Student &otherStudent){
        return score<otherStudent.score;
    }
    
    friend ostream& operator<<(ostream &os, const Student &student){
        os<<"St"
    }
};

#endif /* Student_h */
