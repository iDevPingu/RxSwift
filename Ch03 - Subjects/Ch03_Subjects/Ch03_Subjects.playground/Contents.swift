import UIKit
import RxSwift
import RxRelay

example(of: "PublishSubject") {
    let subject = PublishSubject<String>()
    subject.on(.next("Is anyone listening?"))
    
    // 현재 subject는 emit 할 이벤트가 없음
    let subscriptionOne = subject
        .subscribe(onNext: { string in
            print(string)
        },
        onCompleted: {
            print("Completed")
        })
    subject.onNext("Hello")
    subject.on(.next("Bye"))
//    subject.onCompleted()
    
    let subscriptionTwo = subject
        .subscribe{ event in
            print("2)", event.element ?? event)
        }
    subject.onNext("3")
    
    subscriptionOne.dispose() // 이제부턴 Two만 이벤트 수신
    subject.onNext("4")
    
    subject.onCompleted()
    
    subject.onNext("5")
    subscriptionTwo.dispose()
    let disposeBag = DisposeBag()
    
    subject
        .subscribe {
            print("3)", $0.element ?? $0)
        }.disposed(by: disposeBag)
    subject.onNext("?")
    
}
enum MyError: Error {
    case anError
}
func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, (event.element ?? event.error) ?? event)
}
example(of: "BehaviorSubject") {
    let subject = BehaviorSubject(value: "Initial value")
    let disposeBag = DisposeBag()
    
    subject
        .subscribe {
            print(label: "1)", event: $0)
        }.disposed(by: disposeBag)
    
    subject.onNext("A")
    
    subject.onError(MyError.anError)
    
    subject
        .subscribe {
            print(label: "2)", event: $0)
        }.disposed(by: disposeBag)
}

example(of: "ReplaySubjects") {
    let subject = ReplaySubject<Int>.create(bufferSize: 2)
    subject.onNext(1)
    subject.onNext(2)
    subject.onNext(3)
    
    subject.subscribe { event in
        print(label: "1) ", event: event)
    }
    
    subject.subscribe { event in
        print(label: "2) ", event: event)
    }
    
    subject.onNext(4)
    subject.onError(MyError.anError)
    subject.dispose()
    subject.subscribe { event in
        print(label: "3) ", event: event)
    }
    
}
