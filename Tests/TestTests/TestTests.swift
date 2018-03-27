/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

@testable import Test
class TestTests: TestCase {
    func testThrows() {
        func throwsError() throws {}
        scope {
            try throwsError()
        }
    }

    func testLifetime() {
        class Test {
            let descrtuctor: () -> Void

            init(_ descrtuctor: @escaping () -> Void) {
                self.descrtuctor = descrtuctor
            }

            deinit {
                descrtuctor()
            }
        }

        var called = false
        scope {
            _ = Test {
                called = true
            }
        }
        assertTrue(called)
    }
}
