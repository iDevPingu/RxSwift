import UIKit
import RxSwift
import RxRelay

public func example(of description: String,
                    action: () -> Void) {
  print("\n--- Example of:", description, "---")
  action()
}

example(of: "ignoreElements") {
    let strikes = PublishSubject<String>()
    let disposeBag = DisposeBag()
    
    strikes
        .ignoreElements()
        .subscribe { _ in
            print("You're out")
        }
        .disposed(by: disposeBag)
    
    strikes.onNext("X")
    strikes.onNext("X")
    strikes.onNext("X")
    strikes.onCompleted()
}

example(of: "elementAt") {
    let strikes = PublishSubject<String>()
    let disposeBag = DisposeBag()
    
    strikes
        .elementAt(2)
        .subscribe(onNext: { _ in
            print("You're out!")
        })
        .disposed(by: disposeBag)
    
    strikes.onNext("X")
    strikes.onNext("X")
    strikes.onNext("X") // 이 때만 evnet 수신
    strikes.onNext("X")
}

example(of: "filter") {
    let disposeBag = DisposeBag()
    Observable.of(1,2,3,4,5,6,7,8)
        .filter { number in
            number % 2 == 1
        }
        .subscribe(onNext: { number in
            print(number)
        })
        .disposed(by: disposeBag)
}
