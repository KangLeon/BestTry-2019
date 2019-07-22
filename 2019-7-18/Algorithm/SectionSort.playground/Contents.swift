import UIKit

protocol SortType {
    func sort(items: Array<Int>) -> Array<Int>
}

class BubbleSort: SortType {
    func sort(items: Array<Int>) -> Array<Int> {
        print("冒泡排序：")
        var list = items
        for i in 0..<list.count {
            print("第\(i+1)轮冒泡：")
            var j = list.count-1
            while j>1 {
                if list[j-1] > list[j] {
                    //前边的大于后边的则进行交换
                    let temp = list[j]
                    list[]
                    
                }
            }
            
        }
    }
}
