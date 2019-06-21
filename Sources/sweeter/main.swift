//
//  main.swift
//  sweeter
//
//  Copyright (c) 2019 Jason Nam (https://jasonnam.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import SwiftSyntax
import Bouncer
import SweeterKit

let defaultCommand = Command(operandType: .equal(1)) { _, _, operands, _ in
    let fileURL = URL(fileURLWithPath: operands[0])

    let syntaxTree: SourceFileSyntax
    do {
        syntaxTree = try SyntaxTreeParser.parse(fileURL)
    } catch {
        print(error.localizedDescription)
        return
    }

    let syntaxTreeVisitor = SyntaxTreeVisitor(
        syntaxRewriters: [
            EqualTokenSpacingFormatter()
        ]
    )

    let formattedSyntaxTree = syntaxTreeVisitor.visit(syntaxTree)
    do {
        try formattedSyntaxTree.description.write(to: fileURL, atomically: true, encoding: .utf8)
    } catch {
        print(error.localizedDescription)
        return
    }
}

let program = Program(commands: [defaultCommand])
let arguments = Array(CommandLine.arguments.dropFirst())
do {
    try program.run(withArguments: arguments)
} catch {
    print(error.localizedDescription)
}
