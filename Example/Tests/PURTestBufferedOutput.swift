//
//  PURTestBufferedOutput.swift
//  Puree
//
//  Created by tomohiro-moro on 12/10/14.
//  Copyright (c) 2014 Tomohiro Moro. All rights reserved.
//

import Foundation
import Puree

class PURTestBufferedOutput : PURBufferedOutput {
    var logStorage: TestLogStorage!

    override func configure(settings: [String : AnyObject]) {
        super.configure(settings)

        self.logStorage = settings["logStorage"] as! TestLogStorage
    }

    override func writeChunk(chunk: PURBufferedOutputChunk, completion: (Bool) -> Void) {
        let logString = chunk.logs.reduce("") { (result, log) -> String in
            let userInfo = log.userInfo as! [String: String]
            let record = userInfo.keys.sort().map { "\($0)=\(log.userInfo[$0]!)" }.joinWithSeparator("_")

            return result + "\(log.tag)-\(record)/"
        }
        self.logStorage.addLog(logString)
        completion(true);
    }
}
