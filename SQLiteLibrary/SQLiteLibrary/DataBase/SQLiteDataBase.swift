//
//  SQLiteDataBase.swift
//  SQLiteLibrary
//
//  Created by 王 on 2017/07/09.
//  Copyright © 2017年 WangJun. All rights reserved.
//

import Foundation
import SQLite

class SQLiteDataStore {
    static let sharedInstance = SQLiteDataStore()
    let BBDB:Connection?
    
    private init(){
        var path = "BaseballDB.sqlite"
        let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        path = dir.appending(path)
        
        do{
            BBDB = try Connection(path)
        }catch{
            BBDB = nil
        }
    }
    
    func createTables()throws {
        do{
            try TeamDataHelper.createTable()
        }catch{
            throw DataAccessError.Datastore_Connection_Error
        }
    }
}

typealias Team = (
    teamId: Int64?,
    city: String?,
    nickName: String?,
    abbreviation: String?
)

protocol DataHelperProtocol {
    associatedtype T
    static func createTable() throws -> Void
    static func insert(item:T) throws -> Int
    static func delete(item:T) throws -> Void
    static func findAll() throws -> [T]?
}

enum DataAccessError: Error {
    case Datastore_Connection_Error
    case Insert_Error
    case Delete_Error
    case Search_Error
    case Nil_In_Data
    case CreateTable_Error
}

class TeamDataHelper: DataHelperProtocol {
    static let TABLE_NAME = "Teams"
    static let table = Table(TABLE_NAME)
    static let teamId = Expression<Int64>("teamid")
    static let city = Expression<String>("city")
    static let nickName = Expression<String>("nickname")
    static let abbreviation = Expression<String>("abbreviation")
    typealias T = Team
    
    static func find(id: Int64) throws -> T? {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        let query = table.filter(teamId == id)
        do{
            let items = try DB.prepare(query)
            for item in  items {
                return Team(teamId: item[teamId] , city: item[city], nickName: item[nickName], abbreviation: item[abbreviation])
            }
        }
        return nil
    }
    
    static func findAll() throws -> [Team]? {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        var retArray = [T]()
        do{
            let items = try DB.prepare(table)
            for item in items {
                retArray.append(Team(teamId: item[teamId], city: item[city], nickName: item[nickName], abbreviation: item[abbreviation]))
            }
        }
        return retArray
    }

    static func delete(item: Team) throws {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        
        if let id = item.teamId {
            let query = table.filter(teamId==id)
            do{
                let tmp = try DB.run(query.delete())
                guard tmp==1 else {
                    throw DataAccessError.Delete_Error
                }
            }catch{
                throw DataAccessError.Delete_Error
            }
        }
    }

    static func insert(item: Team) throws -> Int {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error }
        
        if !(item.city==nil) && !(item.nickName==nil) && !(item.abbreviation==nil) {
            let insert = table.insert(city <- item.city!,nickName <- item.nickName!,abbreviation <- item.abbreviation!)
            do{
                let rowId = try DB.run(insert)
                guard rowId>0 else{
                    throw DataAccessError.Insert_Error
                }
                return Int(rowId)
            }catch{
                throw DataAccessError.Insert_Error
            }
        }
        throw DataAccessError.Nil_In_Data
    }

    static func createTable() throws {
        guard let DB = SQLiteDataStore.sharedInstance.BBDB else
        {
            throw DataAccessError.Datastore_Connection_Error
        }
        
        do{
            _ = try DB.run(table.create(ifNotExists:true){
                t in
                t.column(teamId,primaryKey: true)
                t.column(city)
                t.column(nickName)
                t.column(abbreviation)
            })
        }catch{
            throw DataAccessError.CreateTable_Error
        }
    }
}
