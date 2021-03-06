//: Playground - noun: a place where people can play

import UIKit
import Ents
import PlaygroundSupport

//let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 400, height: 400))
//let view = UIView(frame: frame)
//
//let red = UIView(frame: frame.with(width: 50).with(height: 50))
//red.backgroundColor = UIColor.red
//view.addSubview(red)

struct E {
    let id: Int
    let amount: Int
}

let amounts = [100, 200, 300]

let entries = (0..<10).map({ (i: Int) -> E in
    return E(id: i, amount: amounts[Int(arc4random_uniform(3))] )
})

let ids = entries
    .stableSorted({ (e1: E, e2: E) -> Bool in
        return e1.id < e2.id
    })

ids.stableSorted({ (e1: E, e2: E) -> Bool in
    return e1.amount > e2.amount
})


//let topCenter = UIView.equalTopCenter()
//topCenter(red, view)

//PlaygroundPage.current.liveView = view

//var q2: FIFO<Int> = [1,2,3]
//
//q2.startIndex
//q2.endIndex
//q2.count
//
//q2[0]
//q2[1]
//q2[2]
//
//
//q2.enqueue(4)
//q2.count
//q2.endIndex
//q2[3]
//
//q2.dequeue()
//q2
//q2.dequeue()
//q2
//q2.dequeue()
//q2
//q2.dequeue()
//q2
//q2.dequeue()
//q2

//let list: List<Int> = [1,2,3,4]
//list.car()

//list[0...2]

//var l = list
//l.push(5)
//l.pop()
//l
//l.pop()
//l
//l.pop()
//l
//l.pop()
//l
//l.pop()
//l
//l.pop()
//l


//list.car()
//list.cdr().car()
//list.cdr().cdr().car()
//list.cdr().cdr().cdr().car()
//list.cdr().cdr().cdr().cdr()


//struct Person {
//    let first: String
//    let last: String
//    let yearOfBirth: Int
//}
//
//let people = [
//    Person(first: "Jo", last: "Smith", yearOfBirth: 1970),
//    Person(first: "Joe", last: "Smith", yearOfBirth: 1970),
//    Person(first: "Joe", last: "Smyth", yearOfBirth: 1970),
//    Person(first: "Joanne", last: "smith", yearOfBirth: 1985),
//    Person(first: "Joanne", last: "smith", yearOfBirth: 1970),
//    Person(first: "Robert", last: "Jones", yearOfBirth: 1970)
//]
//
////let sortByYearAlt: SortDescriptor<Person>
////    = sortDescriptor(key: { $0.yearOfBirth }, <)
////print(people.sorted(by: sortByYearAlt))
//
//let sortByYear: SortDescriptor<Person>
//    = sortDescriptor(key: {$0.yearOfBirth})
//
//let sortByFirstName: SortDescriptor<Person>
//    = sortDescriptor(key: {$0.first}, String.localizedCaseInsensitiveCompare)
//
//let sortByLastName: SortDescriptor<Person>
//    = sortDescriptor(key: {$0.last}, String.localizedCaseInsensitiveCompare)
//
//let combined: SortDescriptor<Person> =
//    combine(sortDescriptors: [sortByLastName, sortByFirstName, sortByYear])
//print(people.sorted(by: combined))


