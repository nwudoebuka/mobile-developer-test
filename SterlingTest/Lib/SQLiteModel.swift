//
//  SQLiteModel.swift
//  SterlingTest
//
//  Created by Nwudo Ebuka on 8/10/19.
//  Copyright © 2019 Nuture Tech. All rights reserved.
//

import Foundation
import SQLite3
class SQLiteModel{
    internal let SQLITE_STATIC = unsafeBitCast(0, to: sqlite3_destructor_type.self)
    internal let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    func setUpSQlite(db:OpaquePointer?){
          var passeddb = db
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("livescore.sqlite")
        
        // open database
        
        
        if sqlite3_open(fileURL.path, &passeddb) != SQLITE_OK {
            print("error opening database")
        }
        
        if sqlite3_exec(passeddb, " SELECT name FROM sqlite_master WHERE type='table' AND name='competition';", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("error checking competition: \(errmsg)")
        }else{
            if sqlite3_exec(passeddb, "DROP TABLE competition", nil, nil, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
                print("error droping competition: \(errmsg)")
            }
            
        }
        
        if sqlite3_exec(passeddb, " SELECT name FROM sqlite_master WHERE type='table' AND name='teams';", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("error checking competition: \(errmsg)")
        }else{
            if sqlite3_exec(passeddb, "DROP TABLE teams", nil, nil, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
                print("error droping teams: \(errmsg)")
            }
            
        }
        
        
        if sqlite3_exec(passeddb, " SELECT name FROM sqlite_master WHERE type='table' AND name='standings';", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("error checking standings: \(errmsg)")
        }else{
            if sqlite3_exec(passeddb, "DROP TABLE standings", nil, nil, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
                print("error droping standings: \(errmsg)")
            }
            

        }
        
        
        
        //table for today fixture
        if sqlite3_exec(passeddb, " SELECT name FROM sqlite_master WHERE type='table' AND name='todayfix';", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("error checking today fixtures: \(errmsg)")
        }else{
            if sqlite3_exec(passeddb, "DROP TABLE todayfix", nil, nil, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
                print("error droping today fixtures: \(errmsg)")
            }else{
                print("dropped todayfix table")
            }
            
        }
        
        if sqlite3_exec(passeddb, " SELECT name FROM sqlite_master WHERE type='table' AND name='todayfix';", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("error checking today fixtures: \(errmsg)")
        }else{
            if sqlite3_exec(passeddb, "DROP TABLE squad", nil, nil, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
                print("error droping squad: \(errmsg)")
            }else{
                print("dropped squad table")
            }
            
        }
        
        
        
        
        if sqlite3_exec(passeddb, "create table if not exists standings (id integer primary key autoincrement, logo text, team text,win text,draw text,lost text,position text,league_id text)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("error creating table standings: \(errmsg)")
        }else{
            print("created standings")
        }
        
        if sqlite3_exec(passeddb, "create table if not exists teams (id integer primary key autoincrement, logo text, name text, league_id text, teamid text)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("error creating table standings: \(errmsg)")
        }else{
            print("created standings")
        }
        
        
        
        
        
        
        //creating table
        if sqlite3_exec(passeddb, "create table if not exists competition (id integer primary key autoincrement, name text, league_id text)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("error creating table competition: \(errmsg)")
        }else{
            print("created competition")
        }
        
        if sqlite3_exec(passeddb, "create table if not exists todayfix (id integer primary key autoincrement, status text, time text, hometeam text, awayteam text, fullhomescore text, fullawayscore text, halfhomescore text, halfawayscore text)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("error creating table todayfix: \(errmsg)")
        }else{
            print("created todayfix table")
        }
        
        
        if sqlite3_exec(passeddb, "create table if not exists squad (id integer primary key autoincrement, number text, name text, position text, logo text, team_id text)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("error creating table todayfix: \(errmsg)")
        }else{
            print("created todayfix table")
        }
        
      
        
    }
    func insertSquad(db:OpaquePointer?,number:NSString,name:NSString,position:NSString,logo:NSString,teamid:NSString){
        
        var passeddb = db
        //inserting into database
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("livescore.sqlite")
        
        // open database
        
        
        if sqlite3_open(fileURL.path, &passeddb) != SQLITE_OK {
            print("error opening database")
        }
        
        if sqlite3_prepare_v2(passeddb, "insert into squad (number,name,position,logo,team_id) values (?,?,?,?,?)", -1, &passeddb, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("error preparing insert: \(errmsg)")
        }
        
        
        if sqlite3_bind_text(passeddb, 1, number.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding foo: \(errmsg)")
        }
        
        if sqlite3_bind_text(passeddb, 2, name.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure binding foo: \(errmsg)")
        }
        if sqlite3_bind_text(passeddb, 3, position.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure binding foo: \(errmsg)")
        }
        if sqlite3_bind_text(passeddb, 4, logo.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure binding foo: \(errmsg)")
        }
        if sqlite3_bind_text(passeddb, 5, teamid.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure binding foo: \(errmsg)")
        }
        
        if sqlite3_step(passeddb) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure inserting todayfix: \(errmsg)")
        }
        
        
        
        
        //recovering memory associated with prepared statement
        if sqlite3_finalize(passeddb) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        passeddb = nil
        
        ////
        
        
    }
    
    func insertTodayFix(db:OpaquePointer?,status:NSString,time:NSString,hometeam:NSString,awayteam:NSString,fullhomescore:NSString,fullawayscore:NSString,halfhomescore:NSString,halfawayscore:NSString){
       
        var passeddb = db
        //inserting into database
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("livescore.sqlite")
        
        // open database
        
        
        if sqlite3_open(fileURL.path, &passeddb) != SQLITE_OK {
            print("error opening database")
        }
       
        if sqlite3_prepare_v2(passeddb, "insert into todayfix (status,time,hometeam,awayteam,fullhomescore,fullawayscore,halfhomescore,halfawayscore) values (?,?,?,?,?,?,?,?)", -1, &passeddb, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("error preparing insert: \(errmsg)")
        }
        
        
        if sqlite3_bind_text(passeddb, 1, status.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding foo: \(errmsg)")
        }
        
        if sqlite3_bind_text(passeddb, 2, time.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure binding foo: \(errmsg)")
        }
        if sqlite3_bind_text(passeddb, 3, hometeam.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure binding foo: \(errmsg)")
        }
        if sqlite3_bind_text(passeddb, 4, awayteam.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure binding foo: \(errmsg)")
        }
        if sqlite3_bind_text(passeddb, 5, fullhomescore.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure binding foo: \(errmsg)")
        }
        if sqlite3_bind_text(passeddb, 6, fullawayscore.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure binding foo: \(errmsg)")
        }
        if sqlite3_bind_text(passeddb, 7, halfhomescore.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure binding foo: \(errmsg)")
        }
        if sqlite3_bind_text(passeddb, 8, halfawayscore.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure binding foo: \(errmsg)")
        }
        if sqlite3_step(passeddb) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure inserting todayfix: \(errmsg)")
        }
        
        
        
        
        //recovering memory associated with prepared statement
        if sqlite3_finalize(passeddb) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        passeddb = nil
        
        ////
        
        
    }
    
    
    
    
    func insertCompetetions(db:OpaquePointer?,name:NSString,leagueId:NSString){
        
        var passeddb = db
        //inserting into database
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("livescore.sqlite")
        
        // open database
        
        
        if sqlite3_open(fileURL.path, &passeddb) != SQLITE_OK {
            print("error opening database")
        }
        if sqlite3_prepare_v2(passeddb, "insert into competition (name,league_id) values (?,?)", -1, &passeddb, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("error preparing insert: \(errmsg)")
        }
        
        
        if sqlite3_bind_text(passeddb, 1, name.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding foo: \(errmsg)")
        }
        
        if sqlite3_bind_text(passeddb, 2, leagueId.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure binding foo: \(errmsg)")
        }
        
        
        
        if sqlite3_step(passeddb) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure inserting competetions: \(errmsg)")
        }
        
        
        
        
        //recovering memory associated with prepared statement
        if sqlite3_finalize(passeddb) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        passeddb = nil
        
        ////
        
        
    }
    
    func insertStandings(db:OpaquePointer?,logo:NSString,team:NSString,win:NSString,draw:NSString,lost:NSString,position:NSString,leagueId:NSString){
        
        var passeddb = db
        //inserting into database
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("livescore.sqlite")
        
        // open database
        
        
        if sqlite3_open(fileURL.path, &passeddb) != SQLITE_OK {
            print("error opening database")
        }
        if sqlite3_prepare_v2(passeddb, "insert into standings (team,win,draw,lost,position,league_id,logo) values (?,?,?,?,?,?,?)", -1, &passeddb, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("error preparing insert: \(errmsg)")
        }
        
        
        if sqlite3_bind_text(passeddb, 1, team.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding foo: \(errmsg)")
        }
        
        if sqlite3_bind_text(passeddb, 2, win.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure binding foo: \(errmsg)")
        }
        if sqlite3_bind_text(passeddb, 3, draw.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure binding foo: \(errmsg)")
        }
        if sqlite3_bind_text(passeddb, 4, lost.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure binding foo: \(errmsg)")
        }
        if sqlite3_bind_text(passeddb, 5, position.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure binding foo: \(errmsg)")
        }
        if sqlite3_bind_text(passeddb, 6, leagueId.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure binding foo: \(errmsg)")
        }
        if sqlite3_bind_text(passeddb, 7, logo.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure binding foo: \(errmsg)")
        }
        
        
        if sqlite3_step(passeddb) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure inserting standings: \(errmsg)")
        }
        
        
        
        
        //recovering memory associated with prepared statement
        if sqlite3_finalize(passeddb) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        passeddb = nil
        
        ////
        
        
    }
    
    func insertTeams(db:OpaquePointer?,logo:NSString,name:NSString,leagueId:NSString,teamid:NSString){
        
        var passeddb = db
        //inserting into database
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("livescore.sqlite")
        
        // open database
        
        
        if sqlite3_open(fileURL.path, &passeddb) != SQLITE_OK {
            print("error opening database")
        }
       
        if sqlite3_prepare_v2(passeddb, "insert into teams (logo,name,league_id,teamid) values (?,?,?,?)", -1, &passeddb, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("error preparing insert: \(errmsg)")
        }
        
        
        if sqlite3_bind_text(passeddb, 1, logo.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding foo: \(errmsg)")
        }
        
        if sqlite3_bind_text(passeddb, 2, name.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure binding foo: \(errmsg)")
        }
        if sqlite3_bind_text(passeddb, 3, leagueId.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure binding foo: \(errmsg)")
        }
        if sqlite3_bind_text(passeddb, 4, teamid.utf8String, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure binding foo: \(errmsg)")
        }
        
        
        if sqlite3_step(passeddb) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("failure inserting standings: \(errmsg)")
        }
        
        
        
        
        //recovering memory associated with prepared statement
        if sqlite3_finalize(passeddb) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        passeddb = nil
        
        ////
        
        
    }
    
    func getTeams(db:OpaquePointer?,leagueId:String)->[[String:String]]{
        var passeddb = db
        var name = ""
        var logo = ""
        var teamid = ""
        var teamArray:[[String:String]] = [[String:String]]()
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("livescore.sqlite")
        
        // open database
        
        
        if sqlite3_open(fileURL.path, &passeddb) != SQLITE_OK {
            print("error opening database")
        }
        
        
        
        if sqlite3_prepare_v2(passeddb, "select id, name, logo, teamid from teams where league_id = "+leagueId+"", -1, &passeddb, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
        }
        
        while sqlite3_step(passeddb) == SQLITE_ROW {
            
            let id = sqlite3_column_int64(passeddb, 0)
            
            
            //print("id = \(id); ", terminator: "")
            
            if let cString = sqlite3_column_text(passeddb, 1) {
                let nam = String(cString: cString)
                name = nam
                print("name is = \(name)")
            } else {
                print("stat not found")
            }
            
            if let cString = sqlite3_column_text(passeddb, 2) {
                logo = String(cString: cString)
                
                print("logo = \(logo)")
            } else {
                print("leagueid not found")
            }
            
            if let cString = sqlite3_column_text(passeddb, 3) {
                teamid = String(cString: cString)
                
                print("teamid = \(teamid)")
            } else {
                print("leagueid not found")
            }
            
            
            
            
            teamArray.append(["name":name,"logo":logo,"teamid":teamid])
            
        }
        
        
        if sqlite3_finalize(passeddb) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        
        
        return teamArray
    }
    
    func getSquad(db:OpaquePointer?,teamId:String)->[[String:String]]{
        var passeddb = db
        var name = ""
        var logo = ""
        var position = ""
        var number = ""
        var squadArray:[[String:String]] = [[String:String]]()
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("livescore.sqlite")
        
        // open database
        
        
        if sqlite3_open(fileURL.path, &passeddb) != SQLITE_OK {
            print("error opening database")
        }
        
        
        
        if sqlite3_prepare_v2(passeddb, "select id, name, number, position, logo from squad where team_id = "+teamId+"", -1, &passeddb, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
        }
        
        while sqlite3_step(passeddb) == SQLITE_ROW {
            
            let id = sqlite3_column_int64(passeddb, 0)
            
            
            //print("id = \(id); ", terminator: "")
            
            if let cString = sqlite3_column_text(passeddb, 1) {
                let nam = String(cString: cString)
                name = nam
                print("name is = \(name)")
            } else {
                print("stat not found")
            }
            
            if let cString = sqlite3_column_text(passeddb, 2) {
                number = String(cString: cString)
                
                print("logo = \(logo)")
            } else {
                print("leagueid not found")
            }
            
            if let cString = sqlite3_column_text(passeddb, 3) {
                position = String(cString: cString)
                
                print("teamid = \(position)")
            } else {
                print("leagueid not found")
            }
            
            
            
            
            squadArray.append(["name":name,"logo":logo,"number":number,"position":position])
            
        }
        
        
        if sqlite3_finalize(passeddb) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        
        
        return squadArray
    }
    func getTodayFix(db:OpaquePointer?)->[[String:String]]{
        
        var passeddb = db
        var status = ""
        var time = ""
        var hometeam = ""
        var awayteam = ""
        var fullhomescore = ""
        var fullawayscore = ""
        var halfhomescore = ""
        var halfawayscore = ""
       
        var todayFixArray:[[String:String]] = [[String:String]]()
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("livescore.sqlite")
        
        // open database
        
        
        if sqlite3_open(fileURL.path, &passeddb) != SQLITE_OK {
            print("error opening database")
        }
        
        if sqlite3_prepare_v2(passeddb, "select id, status, time, hometeam, awayteam, fullhomescore, fullawayscore, halfhomescore, halfawayscore from todayfix", -1, &passeddb, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
        }
        
        while sqlite3_step(passeddb) == SQLITE_ROW {
            
            let id = sqlite3_column_int64(passeddb, 0)
            
            
            //print("id = \(id); ", terminator: "")
           
            if let cString = sqlite3_column_text(passeddb, 1) {
                let stat = String(cString: cString)
                status = stat
                print("stat is = \(status)")
            } else {
                print("stat not found")
            }
            
            if let cString = sqlite3_column_text(passeddb, 2) {
                time = String(cString: cString)
                
                print("time = \(time)")
            } else {
                print("leagueid not found")
            }
            
            if let cString = sqlite3_column_text(passeddb, 3) {
                hometeam = String(cString: cString)
                
                print("time = \(time)")
            } else {
                print("leagueid not found")
            }
            if let cString = sqlite3_column_text(passeddb, 4) {
                awayteam = String(cString: cString)
                
                print("time = \(time)")
            } else {
                print("leagueid not found")
            }
            if let cString = sqlite3_column_text(passeddb, 5) {
                fullhomescore = String(cString: cString)
                
                print("time = \(time)")
            } else {
                print("leagueid not found")
            }
            
            if let cString = sqlite3_column_text(passeddb, 6) {
                fullawayscore = String(cString: cString)
                
                print("time = \(time)")
            } else {
                print("leagueid not found")
            }
            
            if let cString = sqlite3_column_text(passeddb, 7) {
                halfhomescore = String(cString: cString)
                
                print("time = \(time)")
            } else {
                print("leagueid not found")
            }
            if let cString = sqlite3_column_text(passeddb, 8) {
                halfawayscore = String(cString: cString)
                
                print("time = \(time)")
            } else {
                print("leagueid not found")
            }
             todayFixArray.append(["status":status,"time":time,"hometeam":hometeam,"awayteam":awayteam,"fullhomescore":fullhomescore,"fullawayscore":fullawayscore,"halfhomescore":halfhomescore,"halfawayscore":halfawayscore])
            
        }
        
        
        if sqlite3_finalize(passeddb) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        
        
        return todayFixArray
        }
   
    func getCompetitions(db:OpaquePointer?)->[[String:String]]{
        //selecting from database
        var passeddb = db
        var lgName = ""
        var lgid = ""
        var lgnumber = ""
        var leagueArray:[[String:String]] = [[String:String]]()
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("livescore.sqlite")
        
        // open database
        
        
        if sqlite3_open(fileURL.path, &passeddb) != SQLITE_OK {
            print("error opening database")
        }
        if sqlite3_prepare_v2(passeddb, "select id, name, league_id from competition", -1, &passeddb, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
        }
        
        while sqlite3_step(passeddb) == SQLITE_ROW {
            
            let id = sqlite3_column_int64(passeddb, 0)
            lgnumber = String(id)
            
            //print("id = \(id); ", terminator: "")
            
            if let cString = sqlite3_column_text(passeddb, 1) {
                let name = String(cString: cString)
                lgName = name
                print("name = \(name)")
            } else {
                print("name not found")
            }
            
            if let cString = sqlite3_column_text(passeddb, 2) {
                let leagueId = String(cString: cString)
                lgid = leagueId
                print("leagueid = \(leagueId)")
            } else {
                print("leagueid not found")
            }
            
            leagueArray.append(["id":lgid,"name":lgName,"number":lgnumber])
            
        }
        
        
        if sqlite3_finalize(passeddb) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        
        
        return leagueArray
    }
    func deleteSquad(db:OpaquePointer?,id:String){
        var passeddb = db
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("livescore.sqlite")
        
        // open database
        
        
        if sqlite3_open(fileURL.path, &passeddb) != SQLITE_OK {
            print("error opening database")
        }
        let deleteStatementStirng = "delete from squad where team_id = "+id+";"
        
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(passeddb, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted squad row.")
            } else {
                print("Could not delete squad row.")
            }
        } else {
            print("DELETE statement could not be prepared for squad")
        }
        
        sqlite3_finalize(deleteStatement)
        
    }
    
    func deleteAllTeams(db:OpaquePointer?){
        var passeddb = db
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("livescore.sqlite")
        
        // open database
        
        
        if sqlite3_open(fileURL.path, &passeddb) != SQLITE_OK {
            print("error opening database")
        }
        let deleteStatementStirng = "delete from teams;"
        
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(passeddb, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted teams row.")
            } else {
                print("Could not delete teams row.")
            }
        } else {
            print("DELETE statement could not be prepared for teams")
        }
        
        sqlite3_finalize(deleteStatement)
        
    }
    
    
    func deleteTeams(db:OpaquePointer?,id:String){
        var passeddb = db
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("livescore.sqlite")
        
        // open database
        
        
        if sqlite3_open(fileURL.path, &passeddb) != SQLITE_OK {
            print("error opening database")
        }
        let deleteStatementStirng = "delete from teams where league_id = "+id+";"
        
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(passeddb, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted team row.")
            } else {
                print("Could not delete team row.")
            }
        } else {
            print("DELETE statement could not be prepared for team")
        }
        
        sqlite3_finalize(deleteStatement)
        
    }
    func deleteStanding(db:OpaquePointer?,id:String){
        var passeddb = db
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("livescore.sqlite")
        
        // open database
        
        
        if sqlite3_open(fileURL.path, &passeddb) != SQLITE_OK {
            print("error opening database")
        }
        let deleteStatementStirng = "delete from standings where league_id = "+id+";"
        
            var deleteStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(passeddb, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
                if sqlite3_step(deleteStatement) == SQLITE_DONE {
                    print("Successfully deleted row.")
                } else {
                    print("Could not delete row.")
                }
            } else {
                print("DELETE statement could not be prepared")
            }
            
            sqlite3_finalize(deleteStatement)
        
    }
    func getStandings(db:OpaquePointer?,leagueId:String)->[[String:String]]{
        //selecting from database
        var passeddb = db
        var name = ""
        var win = ""
        var draw = ""
        var lost = ""
        var position = ""
        var logo = ""
        var teamArray:[[String:String]] = [[String:String]]()
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("livescore.sqlite")
        
        // open database
        
        
        if sqlite3_open(fileURL.path, &passeddb) != SQLITE_OK {
            print("error opening database")
        }
        if sqlite3_prepare_v2(passeddb, "select id, team, win, draw, lost, position, logo from standings where league_id = "+leagueId+"", -1, &passeddb, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
        }
        
        while sqlite3_step(passeddb) == SQLITE_ROW {
            
            let id = sqlite3_column_int64(passeddb, 0)
           
            
            //print("id = \(id); ", terminator: "")
            
            if let cString = sqlite3_column_text(passeddb, 1) {
                let team = String(cString: cString)
                name = team
                print("name = \(name)")
            } else {
                print("name not found")
            }
            
            if let cString = sqlite3_column_text(passeddb, 2) {
                let windb = String(cString: cString)
                win = windb
                print("win = \(win)")
            } else {
                print("win not found")
            }
            if let cString = sqlite3_column_text(passeddb, 3) {
                let drawdb = String(cString: cString)
                draw = drawdb
                print("draw = \(draw)")
            } else {
                print("draw not found")
            }
            
            if let cString = sqlite3_column_text(passeddb, 4) {
                let lostdb = String(cString: cString)
                lost = lostdb
                print("lost = \(lost)")
            } else {
                print("lost not found")
            }
            
            if let cString = sqlite3_column_text(passeddb, 5) {
                let positiondb = String(cString: cString)
                position = positiondb
                print("lost = \(position)")
            } else {
                print("lost not found")
            }
            if let cString = sqlite3_column_text(passeddb, 6) {
                let logodb = String(cString: cString)
                logo = logodb
                print("logo = \(logo)")
            } else {
                print("lost not found")
            }
            
            teamArray.append(["name":name,"win":win,"draw":draw,"lost":lost,"position":position,"logo":logo])
            
        }
        
        
        if sqlite3_finalize(passeddb) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(passeddb)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        
        
        
        return teamArray
    }
    
}
