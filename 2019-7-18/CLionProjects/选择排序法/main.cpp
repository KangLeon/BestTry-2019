#include <iostream>
#include <cstring>

using namespace std;

struct Books {
    char title[50];
    char author[50];
    char subject[100];
    int book_id;
};

int main ()
{
   Books Book1;
   Books Book2;

   stpcpy(Book1.title,"C++ 教程");
   stpcpy(Book1.author,"Runoob");
   stpcpy(Book1.subject,"编程语言");
   Book1.book_id=12345;

   stpcpy(Book2.title,"CSS 教程");
   stpcpy(Book2.author,"Runoob");
   stpcpy(Book2.subject,"前端技术");
   Book2.book_id=12346;

   cout << "第一本书标题：" << Book1.title << endl;
   cout << "第一本书作者: " << Book1.author << endl;
   cout << "第一本书类目：" << Book1.subject << endl;
   cout << "第一本书 ID：" << Book1.book_id << endl;

    cout << "第二本书标题：" << Book2.title << endl;
    cout << "第二书作者: " << Book2.author << endl;
    cout << "第二书类目：" << Book2.subject << endl;
    cout << "第二本书 ID：" << Book2.book_id << endl;

    return 0;
}





