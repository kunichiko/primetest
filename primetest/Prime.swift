//
//  Prime.swift
//  primetest
//
//  Created by 大中邦彦 on 2019/08/18.
//  Copyright © 2019 Ripplex, Inc. All rights reserved.
//

import Foundation

let reportingInterval = 500
//var calccount = 0

protocol PrimeGenerator {
    var name: String { get }
    func start(listener: @escaping (Int) -> ())
    func stop()
}

class SwiftPrimeGenerator : PrimeGenerator {
    var name: String {
        return "Swift"
    }
    private var stopped = false
    private var primes = Primes()
    private var count = 0
    
    func start_(listener: @escaping (Int) -> ()) {
        stopped = false
        //        DispatchQueue.global(qos: .userInitiated).async {
        for prime in self.primes {
            if (self.stopped) {
                break
            }
            self.count += 1
            if (self.count % reportingInterval == 0) {
                //                    self.consumer(prime)
                DispatchQueue.main.async {
                    listener(prime)
                }
            }
        }
        //        }
    }

    func start(listener: @escaping (Int) -> ()) {
        stopped = false
        for n in 500000...Int.max {
            if (isPrime(n)) {
                if (self.stopped) {
                    break
                }
                self.count += 1
                if (self.count % reportingInterval == 0) {
                    //                    self.consumer(prime)
                    DispatchQueue.main.async {
                        listener(n)
                    }
                }
            }
        }
    }

    func stop() {
        stopped = true
    }
    
    func reset() {
        stop()
        primes = Primes()
        count = 0
    }
}

fileprivate func isPrime(_ n: Int) -> Bool {
    if (n == 2) {
        return true
    }
    //    for i in 2..<n/2+1 {
    for i in (2..<n).reversed() {
  //      calccount+=1
        if (n % i == 0) {
            return false
        }
    }
    return true
}

struct Primes : Sequence {
    func makeIterator() -> PrimeIterator {
//        calcount = 0
        return PrimeIterator()
    }
}

struct PrimeIterator : IteratorProtocol {
    //private var i = 2
    //    private var i = 1000000
    private var i = 500000
    
    mutating func next() -> Int? {
        for n in i...Int.max {
            //            i += 1
            if (isPrime(n)) {
                i = n + 1
                return n
            }
        }
        return nil
    }
}

var globalListener: ((Int)->())?

class NativePrimeGenerator : PrimeGenerator {
    var name: String {
        return "Native"
    }
    func start(listener: @escaping (Int) -> ()) {
        globalListener = listener
        c_consume_prime = { (prime: Int64) in
            DispatchQueue.main.async {
                globalListener?(Int(prime))
            }
        }
        c_gen_primes_stop = false
        c_gen_primes()
    }
    func stop() {
        c_gen_primes_stop = true
    }
}
