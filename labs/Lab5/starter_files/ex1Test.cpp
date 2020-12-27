#include <iostream>
#include "recursive.h"
#include "ex1.h"

using namespace std;

static bool list_equal(list_t l1, list_t l2)
    // EFFECTS: returns true iff l1 == l2.
{
    if(list_isEmpty(l1) && list_isEmpty(l2))
    {
        return true;
    }
    else if(list_isEmpty(l1) || list_isEmpty(l2))
    {
        return false;
    }
    else if(list_first(l1) != list_first(l2))
    {
        return false;
    }
    else
    {
        return list_equal(list_rest(l1), list_rest(l2));
    }    
}    

int main()
{
    int i, dotAns=0;
    list_t listA, listA_answer;
    list_t listB, listB_answer;

    listA = list_make();
    listB = list_make();
    listA_answer = list_make();

    for(i = 5; i>0; i--)
    {
        listA = list_make(i, listA);
        listB = list_make(i+10, listB);
        dotAns += i*(i+10);
    }

    for(i = 5; i>0; i-=2)
    {
        listA_answer = list_make(i, listA_answer);
    }

    list_print(listA);
    cout << endl;
    list_print(listB);
    cout << endl;
    cout << dot(listA,listB) << endl;
    cout << dotAns << endl;
    list_print(filter_odd(listA));
    cout << endl;
    list_print(listA_answer);
    cout << endl;
    if(dot(listA, listB) == dotAns
        && list_equal(filter_odd(listA), listA_answer))
    {
        cout << "Success!\n";
        return 0;
    }
    else
    {
        cout << "Failed\n";
        return -1;
    }
}
