//
//  CustomTextFieldStyle.swift
//  Project_Version1
//
//  Created by Pro on 10/20/23.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10.0)
            .background(Color("DarkGray"))
            .foregroundStyle(.black)
            .clipShape(RoundedRectangle(cornerRadius: 20.0))
    }
}
#Preview {
    TextField("Testing", text: .constant(""))
        .textFieldStyle(CustomTextFieldStyle())
        .previewLayout(.sizeThatFits)
        .padding()
}
