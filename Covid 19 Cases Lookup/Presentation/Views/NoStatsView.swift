//
//  NoStatsView.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 02/05/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import SwiftUI

struct NoStatsView: View {
    var body: some View {
        Text("No stats for this country\nCheck againg later")
            .multilineTextAlignment(.center)
            .foregroundColor(Color.green)
            .padding()
            .shadow(radius: 2)
            .rotation3DEffect(.degrees(20), axis: (1, 0, 0))
    }
}

struct NoStatsView_Previews: PreviewProvider {
    static var previews: some View {
        NoStatsView()
    }
}
