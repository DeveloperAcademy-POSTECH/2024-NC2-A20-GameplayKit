//
//  MainView.swift
//  NC2
//
//  Created by 임소연 on 6/18/24.
//

import SwiftUI

struct MainView: View {
    @State private var playing = false
    @State private var mute = false
   
    var body: some View {
        if !playing {
            StartView(isplaying: $playing, mute: $mute)
        } else {
            GamePlayView(isplaying: $playing, mute: $mute)
        }
        
    }
}

#Preview {
    MainView()
}
