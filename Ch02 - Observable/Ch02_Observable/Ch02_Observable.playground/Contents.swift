import UIKit
import RxSwift

public func example(of description: String,
                    action: () -> Void) {
    print("\n--- Example of:", description, "---")
    action()
}

example(of: "just, of, from") {
    let one = 1
    let two = 2
    let three = 3
    
//    let observable = Observable<Int>.just(one)
    let observable2 = Observable.of(one, two, three)
    let observable3 = Observable.of([one, two, three])
//    let observable4 = Observable.from([one, two, three])
    
//    observable2.subscribe { event in
//        print(event)
//    }
    observable2.subscribe { event in
        if let element = event.element {
            print(element)
        }
    }
//    observable3.subscribe { event in
//        print(event)
//    }
    observable2.subscribe(onNext: { element in
        print(element)
    })
}

example(of: "empty") {
    let observable = Observable<Void>.empty()
    
    observable.subscribe(
        onNext: { element in
            print(element)
        },
        onCompleted: {
            print("Completed")
        }
    )
}

example(of: "never") {
    let observable = Observable<Void>.never()
    observable.subscribe (
        onNext: { element in
            print(element)
        },
        onCompleted: {
            print("Completed")
        }
    )
}

example(of: "range") {
    let observable = Observable<Int>.range(start: 1, count: 10)
    observable.subscribe(onNext : { i in
            let n = Double(i)
            let fibonacci = Int(
                ((pow(1.61803, n) - pow(0.61803, n)) / 2.23606).rounded()
            )
            print(fibonacci)
        })
}
