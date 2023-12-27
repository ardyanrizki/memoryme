//
//  Dialog.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 25/12/23.
//

import Foundation

/// A structure representing a dialog with a name and a prompt.
struct Dialog {
    /// The name associated with the dialog.
    let name: String?
    
    /// The prompt message for the dialog.
    let prompt: String
    
    /// Initializes a new dialog with a specified name and prompt.
    ///
    /// - Parameters:
    ///   - name: The name associated with the dialog.
    ///   - prompt: The prompt message for the dialog.
    init(_ name: String?, prompt: String) {
        self.name = name
        self.prompt = prompt
    }
}

