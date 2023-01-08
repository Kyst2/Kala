import XCTest

//class StopwatchTests: XCTestCase {
//    func testStartTest() throws {
//        let st = Stopwatch()
//        st.start()
//
//        sleep(ms: 2000)
//
//        let testTimeCorrect = st.diff >= 2 && st.diff <= 2.1
//
//        print("--------\n\(st.diff) sec\n--------\n")
//
//        XCTAssertTrue(testTimeCorrect)
//    }
//
//    func testPauseResume() throws {
//        let st = Stopwatch().start()
//
//        XCTAssertTrue(st.isGoing)
//
//        sleep(ms: 1000)
//
//        st.pause()
//
//        XCTAssertFalse(st.isGoing)
//
//        sleep(ms: 1000)
//
//        st.start()
//
//        sleep(ms: 1000)
//
//        let testTimeCorrect = st.diff >= 2 && st.diff <= 2.1
//
//        print("--------\n\(st.diff) sec\n--------\n")
//
//        XCTAssertTrue(testTimeCorrect)
//    }
//
////    func testFewStarts() throws {
////        let st = Stopwatch().start()
////        sleep(ms: 1000)
////        st.start()
////        sleep(ms: 1000)
////
////        let testTimeCorrect = st.diff >= 2 && st.diff <= 2.1
////
////        print("--------\n\(st.diff) sec\n--------\n")
////
////        XCTAssertTrue(testTimeCorrect)
////    }
//}
////
//public func sleep(ms: Int ) {
//    usleep(useconds_t(ms * 1000))
//}
//
//public func sleep(sec: Double ) {
//    usleep(useconds_t(sec * 1_000_000))
//}
