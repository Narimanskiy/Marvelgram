//
//  SuperHeroCollectionViewCell.swift
//  Marvelgram
//
//  Created by Нариман on 02.05.2021.
//

import UIKit

class InstagramLayout: UICollectionViewLayout {

  fileprivate var cellPadding: CGFloat = 0

  fileprivate var cache = [UICollectionViewLayoutAttributes]()
  fileprivate var contentHeight: CGFloat = 0
  
  fileprivate var contentWidth: CGFloat {
    guard let collectionView = collectionView else {
      return 0
    }
    let insets = collectionView.contentInset
    return collectionView.bounds.width - (insets.left + insets.right)
  }
  
  override var collectionViewContentSize: CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  override func prepare() {

    guard cache.isEmpty == true, let collectionView = collectionView else {
      return
    }

    let numberOfColumns = 3
    let columnsCode = [0,2,2,0,1,2,0,0,1,0,1,2]
    let bigItem = [true,false,false,false,false,false,false,false,true,false,false,false]
    let codeCount = columnsCode.count

    let columnWidth = contentWidth / CGFloat(numberOfColumns)
    var xOffset = [CGFloat]()
    for column in 0 ..< numberOfColumns {
      xOffset.append(CGFloat(column) * columnWidth)
    }
    var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)

    var code = 0
    for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
        let column = columnsCode[code]
        var size = CGSize(width: columnWidth, height: columnWidth)
        if bigItem[code] {
            size = CGSize(width: columnWidth * 2, height: columnWidth * 2)
        }
        let indexPath = IndexPath(item: item, section: 0)
        let height = cellPadding * 2 + size.height
        let frame = CGRect(x: xOffset[column], y: yOffset[column], width: size.width, height: height)
        let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = insetFrame
        cache.append(attributes)

        contentHeight = max(contentHeight, frame.maxY)
        yOffset[column] = yOffset[column] + height
        if bigItem[code] {
            yOffset[column+1] = yOffset[column+1] + height
        }

        code = code < (codeCount - 1) ? (code + 1) : 0
    }
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()

    for attributes in cache {
      if attributes.frame.intersects(rect) {
        visibleLayoutAttributes.append(attributes)
      }
    }
    return visibleLayoutAttributes
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cache[indexPath.item]
  }
  
}
