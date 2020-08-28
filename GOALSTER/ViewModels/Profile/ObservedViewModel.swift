//
//  ObservedViewModel.swift
//  GOALSTER
//
//  Created by Daniyar on 8/20/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class ObservedViewModel {
    lazy var observed = PublishSubject<[Observed]>()
    lazy var success = PublishSubject<Bool>()
    
    var observedResponse: ObservedResponse? {
        didSet {
            guard let observed = observedResponse?.observed else { return }
            self.observed.onNext(observed)
        }
    }
    
    func getObserved() {
        SpinnerView.showSpinnerView()
        APIManager.shared.getObserved() { error, response in
            SpinnerView.removeSpinnerView()
            guard let response = response else {
                return
            }
            self.observedResponse = response
        }
    }
    
    func acceptObservation(id: Int, isConfirmed: Bool) {
        SpinnerView.showSpinnerView()
        APIManager.shared.acceptObservation(id: id, isConfirmed: isConfirmed) { error, response in
            SpinnerView.removeSpinnerView()
            guard let response = response else {
                return
            }
            self.success.onNext(response)
        }
    }
}
