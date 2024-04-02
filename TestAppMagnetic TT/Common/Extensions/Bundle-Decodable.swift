//
//  Bundle-Decodable.swift
//  TestAppMagnetic TT
//
//  Created by Vakhtang on 01.04.2024.
//

import Foundation

extension Bundle {
    
    func decode<T: Decodable>(file: String) -> [T] {
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in the project!")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not find \(file) in the project!")
        }
        
        let decoder = JSONDecoder()
        
        guard let load = try? decoder.decode([T].self, from: data) else {
            fatalError("Could not find \(file) in the project!")
        }
        return load
    }
}
