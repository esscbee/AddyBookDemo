//
//  AddressBook.swift
//  AddyBookDemo
//
//  Created by Stephen Brennan on 8/1/16.
//  Copyright © 2016 Stephen Brennan. All rights reserved.
//

import Foundation

protocol AddressBook : class {
    func getFullNames() -> [String]?
}