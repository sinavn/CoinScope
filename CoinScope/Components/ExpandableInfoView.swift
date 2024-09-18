//
//  ExpandableInfoView.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 6/17/1403 AP.
//

import SwiftUI

struct ExpandableInfoView: View {
    
    var text : String
    @State var isExpanded :Bool = false
    @State var infoTask: Task<(), Error>?
    var body: some View {
        HStack(){
            Image(systemName: "info.circle")
                .foregroundStyle(Color.theme.accentColor.gradient)
                .onTapGesture {
                    infoTask?.cancel()
                    withAnimation {
                        isExpanded = true
                    }
                         infoTask = Task{
                            try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
                            withAnimation {
                                isExpanded = false
                            }
                        }
                    
                }
            Text( isExpanded ? text : "")
                .font(.footnote)
                .foregroundStyle(.gray)
                
        Spacer()
        }
        .frame(maxHeight: 35)
    }
}

#Preview {
    ExpandableInfoView(text: "powered by Etherscan")
}
