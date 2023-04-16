//
//  ApplicationAssembly.swift
//  Jumpeak
//
//  Created by Денис Большачков on 10.04.2023.
//

import Swinject

final class ApplicationAssemby {
    public static var defaultContainer: Container {
        ApplicationAssemby.assmebler.resolver as! Container
    }

    private static var assmebler: Assembler = {
        let assembler = Assembler()
        assembler.apply(assemblies: modulesAssembly)
        assembler.apply(assemblies: otherAssembly)
        
        return assembler
    }()

    private class var modulesAssembly: [Assembly] {
        [
            ViewModelAssembly()
        ]
    }
    
    private class var otherAssembly: [Assembly] {
        [
            ServiceAssembly()
        ]
    }
}
