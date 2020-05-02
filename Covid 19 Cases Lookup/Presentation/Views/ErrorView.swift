//
//  ErrorView.swift
//  Covid 19 Cases Lookup
//
//  Created by Pavel Suvit on 01/05/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import SwiftUI

struct ErrorView: View {
    var retryAction: () -> Void
    var body: some View {
        Button(action: retryAction, label: {
            Text("Something went wrong\nTap to retry")
                .multilineTextAlignment(.center)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        })
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(retryAction: { })
    }
}
