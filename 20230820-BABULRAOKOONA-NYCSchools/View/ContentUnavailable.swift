//
//  ContentUnavailable.swift
//  20230820-BABULRAOKOONA-NYCSchools
//
//  Created by Babul Rao on 21/08/23.
//

import SwiftUI

struct ContentUnavailable: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "tray")
                .renderingMode(.template)
                .resizable()
                .foregroundColor(.red)
                .frame(width: 200, height: 200, alignment: .center)
            Text("No SAT scores to display.\nPlease try after sometime.")
                .font(.headline).bold()
        }
    }
}

struct ContentUnavailable_Previews: PreviewProvider {
    static var previews: some View {
        ContentUnavailable()
    }
}
