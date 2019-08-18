//
//  Primes.c
//  Runner
//
//  Created by Aaron Madlon-Kay on 2019/08/02.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#include "Primes.h"

const int32_t reportingInterval = 500;

bool c_is_prime(int32_t n);

bool c_is_prime(const int32_t n) {
    if (n == 2) {
        return true;
    }
    for (int32_t i = n - 1; i > 1; i--) {
        if (n % i == 0) {
            return false;
        }
    }
    return true;
}

void c_gen_primes() {
//    for (int i = 2, count = 0; !c_gen_primes_stop; i++) {
    int32_t count = 0;
    for (int32_t i = 500000; ; i++) {
        if (c_is_prime(i)) {
            count++;
//            if (count % reportingInterval == 0) {
            if (count == reportingInterval) {
                count = 0;
                c_consume_prime((int64_t)i);
                if (c_gen_primes_stop) {
                    break;
                }
            }
        }
    }
}
