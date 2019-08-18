//
//  Primes.h
//  Runner
//
//  Created by Aaron Madlon-Kay on 2019/08/02.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#ifndef Primes_h
#define Primes_h

#include <stdbool.h>
#include <stdio.h>

volatile bool c_gen_primes_stop;

void (*c_consume_prime)(int64_t);

void c_gen_primes(void);

#endif /* Primes_h */
