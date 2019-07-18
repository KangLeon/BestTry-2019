//
//  ContentView.swift
//  SwiftUIFirst
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 JY. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    var body: some View {
        Text("宝宝，我爱你～")
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
