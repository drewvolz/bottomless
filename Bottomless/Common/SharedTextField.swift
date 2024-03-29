// File: ShareTextfield.swift
// Project: SinglePass

// Created at 13/02/2020 by Liquidcoder
// Visit https://www.liquidcoder.com for more
// Copyright © Liquidcoder. All rights reserved

import SwiftUI

struct SharedTextfield: View {
    @Binding var value: String

    var header = "Email"
    var placeholder = "Your email"
    var trailingIconName = ""
    var errorMessage = ""
    var showUnderline = true
    var onEditingChanged: ((Bool) -> Void) = { _ in }
    var onCommit: (() -> Void) = {}

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(header.uppercased())
                .font(.footnote)

            HStack {
                TextFieldView()
                Icon()
            }
            .frame(height: 45)

            if showUnderline {
                Rectangle().frame(height: 1).foregroundColor(Color.gray)
            }

            ErrorMessage()
        }
    }
}

private extension SharedTextfield {
    @ViewBuilder func TextFieldView() -> some View {
        TextField(placeholder, text: $value, onEditingChanged: { flag in
            self.onEditingChanged(flag)
        }, onCommit: {
            self.onCommit()
        })
        .disableAutocorrection(true)
        .autocapitalization(.none)
        .padding(.vertical, 15)
    }

    @ViewBuilder func Icon() -> some View {
        if !trailingIconName.isEmpty {
            Image(systemName: trailingIconName).foregroundColor(Color.gray)
        }
    }

    @ViewBuilder func ErrorMessage() -> some View {
        if !errorMessage.isEmpty {
            Text(errorMessage)
                .lineLimit(nil)
                .font(.footnote)
                .foregroundColor(Color.red)
                .transition(AnyTransition.opacity.animation(.easeIn))
        }
    }
}

struct SharedTextfield_Previews: PreviewProvider {
    static var previews: some View {
        SharedTextfield(value: .constant(""))
    }
}
