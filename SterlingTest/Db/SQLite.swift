//
//  SQLite.swift
//  SterlingTest
//
//  Created by Nwudo Ebuka on 8/10/19.
//  Copyright © 2019 Nuture Tech. All rights reserved.
//

import Foundation
import SQLite3


class SQLite {
    var db: OpaquePointer?
    internal let SQLITE_STATIC = unsafeBitCast(0, to: sqlite3_destructor_type.self)
    internal let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    
    func setUpDb(){
      
        
        
        openDb()
        
        if sqlite3_exec(self.db, " SELECT name FROM sqlite_master WHERE type='table' AND name='competition';", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(self.db)!)
            print("error checking: \(errmsg)")
        }else{
            dropTable("competition")
            
        }
        
        if sqlite3_exec(self.db, " SELECT name FROM sqlite_master WHERE type='table' AND name='standings';", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(self.db)!)
            print("error checking: \(errmsg)")
        }else{
            dropTable("standings")
            
        }

    }
    
    
    func dropTable(_ table:String){
        if sqlite3_exec(self.db, "DROP TABLE "+table, nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(self.db)!)
            print("error droping table: \(errmsg)")
        }
        
    }

    
    func createTables(){
        
       openDb()
        
        if sqlite3_exec(self.db, "create table if not exists competition (id integer primary key autoincrement, name text, league_id text)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(self.db)!)
            print("error creating table: \(errmsg)")
        }
        
        if sqlite3_exec(self.db, "create table if not exists standings (id integer primary key autoincrement, logo text, team text,win text,draw text,lost text,league_id text)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(self.db)!)
            print("error creating table: \(errmsg)")
        }
    }
    
    func insertCompetetions(_ name:NSString,_ league:NSString){
        openDb()
        if sqlite3_prepare_v2(self.db, "insert into competition (name,league_id) values (?,?)", -1, &self.db, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(self.db)!)
            print("error preparing insert: \(errmsg)")
        }
        
        
        if sqlite3_bind_text(self.db, 1, name.utf8String, -1, self.SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(self.db)!)
            print("failure binding foo: \(errmsg)")
        }
        
        if sqlite3_bind_text(self.db, 2, league.utf8String, -1, self.SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(self.db)!)
            print("failure binding foo: \(errmsg)")
        }
        
       
        
        if sqlite3_step(self.db) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(self.db)!)
            print("failure inserting competetions: \(errmsg)")
        }
        
        
        
        
        //recovering memory associated with prepared statement
        if sqlite3_finalize(self.db) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(self.db)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        self.db = nil
        
        
    }
    func openDb(){
        
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("livescore.sqlite")
        
        // open database
        
        
        if sqlite3_open(fileURL.path, &self.db) != SQLITE_OK {
            print("error opening database")
        }
        
    }
    
    
}
