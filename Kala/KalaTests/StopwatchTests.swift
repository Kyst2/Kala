import XCTest
@testable import Kala

class StopwatchTests: XCTestCase {
    func testStartTest() throws {
        let st = Stopwatch()
        st.start()
        
        print("--------\n\(st.diff) sec\n--------\n")
        
        sleep(ms: 2000)
        
        let testTimeCorrect = st.diff >= 2 && st.diff <= 2.1
        
        print("--------\n\(st.diff) sec\n--------\n")
        
        XCTAssertTrue(testTimeCorrect)
    }

    func testPauseResume() throws {
        let st = Stopwatch().start()

        XCTAssertTrue(st.isGoing)

        sleep(ms: 1000)

        st.pause()

        XCTAssertFalse(st.isGoing)

        sleep(ms: 1000)

        st.start()

        sleep(ms: 1000)

        let testTimeCorrect = st.diff >= 2 && st.diff <= 2.1

        print("--------\n\(st.diff) sec\n--------\n")

        XCTAssertTrue(testTimeCorrect)
    }
    
    func testHrs() throws {
        let st = Stopwatch()
        
        st.setDiff(60 * 60 + 5) // 60 mins + 5 sec
        
        XCTAssertEqual(st.timeStrS, "01:00:05")
        
        st.setDiff(60 * 60 + 70) // 60 mins + 10 sec
        
        XCTAssertEqual(st.timeStrS, "01:01:10")
    }
    
    func testDaysTest() throws {
        let st = Stopwatch()
        
        st.setDiff(60 * 60 * 24 + 5) // 1 day + 5 sec
        
        XCTAssertEqual(st.timeStrS, "1d 00:00:05")
    }

//    func testFewStarts() throws {
//        let st = Stopwatch().start()
//        sleep(ms: 1000)
//        st.start()
//        sleep(ms: 1000)
//
//        let testTimeCorrect = st.diff >= 2 && st.diff <= 2.1
//
//        print("--------\n\(st.diff) sec\n--------\n")
//
//        XCTAssertTrue(testTimeCorrect)
//    }
}
//
public func sleep(ms: Int ) {
    usleep(useconds_t(ms * 1000))
}

public func sleep(sec: Double ) {
    usleep(useconds_t(sec * 1_000_000))
}

func someFunc10() -> Int {
    return 10
}
