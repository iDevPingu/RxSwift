import Foundation
import RxSwift

example(of: "never") {
  let observable = Observable<Any>.never()
  let disposeBag = DisposeBag()
  
  observable
    .do(onSubscribe: {
      print("Subscribed")
    })
    .subscribe(
      onNext: { element in
        print(element)
      },
      onCompleted: {
        print("Completed")
      },
      onDisposed: {
        print("Disposed")
      }
    )
    .disposed(by: disposeBag)
    
    // debug 연산자를 사용하면 해당 Observable이 emit하는 모든 event를 볼 수 있다.
    // 또한 identifier String을 설정할 수 있어서 여러 Observable을 구분하기 좋다.
    observable
        .debug("Hellof", trimOutput: true)
        .subscribe(
            onCompleted: {
                print("Completed!!")
            }
        ).disposed(by: disposeBag)
}

example(of: "of") {
    let observable = Observable<Int>.of(1,2,3)
    let disposeBag = DisposeBag()
    
    observable
        .debug("of Debug", trimOutput: true)
        .subscribe(
            onNext: { element in
                print(element)
            },
            onCompleted: {
                print("Completed~!")
            }
        ).disposed(by: disposeBag)
}

/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.