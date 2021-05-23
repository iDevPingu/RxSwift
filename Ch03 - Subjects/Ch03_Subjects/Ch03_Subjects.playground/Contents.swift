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
    subject.onCompleted()
}
