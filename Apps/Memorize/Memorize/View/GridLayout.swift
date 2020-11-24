//
//  GridLayout.swift
//  Memorize
//
//  Created by CS193p Instructor.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import SwiftUI

struct GridLayout {
    private var size: CGSize
    private var rowCount: Int = 0
    private var columnCount: Int = 0
    var itemSize: CGSize {
        if rowCount == 0 || columnCount == 0 {
            return CGSize.zero
        } else {
            return CGSize(width: size.width / CGFloat(columnCount),
                          height: size.height / CGFloat(rowCount))
        }
    }
    
    init(itemCount: Int, nearAspectRatio desiredAspectRatio: Double = 1, in size: CGSize) {
        self.size = size
        // if our size is zero width or height or the itemCount is not > 0
        // then we have no work to do (because our rowCount & columnCount will be zero)
        guard size.width != 0, size.height != 0, itemCount > 0 else { return }
        
        let layout = bestLayout(for: itemCount, nearAspectRatio: desiredAspectRatio, in: size)
        rowCount = layout.rowCount
        columnCount = layout.columnCount
    }
    
    /// Find the bestLayout i.e., one which results in cells whose aspectRatio
    /// has the smallestVariance from desiredAspectRatio
    /// not necessarily most optimal code to do this, but easy to follow (hopefully)
    private func bestLayout(for itemCount: Int, nearAspectRatio desiredAspectRatio: Double, in size: CGSize) -> (rowCount: Int, columnCount: Int) {
        var bestLayout: (rowCount: Int, columnCount: Int) = (1, itemCount)
        var smallestVariance: Double?
        let sizeAspectRatio = abs(Double(size.width/size.height))
        
        for row in 1...itemCount {
            let columns = (itemCount / row) + (itemCount % row > 0 ? 1 : 0)
            if (row - 1) * columns < itemCount {
                let itemAspectRatio = sizeAspectRatio * (Double(row)/Double(columns))
                let variance = abs(itemAspectRatio - desiredAspectRatio)
                if smallestVariance == nil || variance < smallestVariance! {
                    smallestVariance = variance
                    bestLayout = (rowCount: row, columnCount: columns)
                }
            }
        }
        
        return bestLayout
    }
    
    func location(ofItemAt index: Int) -> CGPoint {
        if rowCount == 0 || columnCount == 0 {
            return CGPoint.zero
        } else {
            return CGPoint(
                x: (CGFloat(index % columnCount) + 0.5) * itemSize.width,
                y: (CGFloat(index / columnCount) + 0.5) * itemSize.height
            )
        }
    }
}
