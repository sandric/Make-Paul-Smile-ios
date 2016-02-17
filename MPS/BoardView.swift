//
//  BoardView.swift
//  MPS
//
//  Created by sandric on 17.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

import UIKit


class BoardView: UIView {
    
    var cellHeight:Int = 0
    var cellWidth:Int = 0
    
    var board:Board!

    func generate(opening:Opening, type:String, viewControllerDelegate:BoardViewControllerDelegate?)
    {
        self.cellHeight = Int(self.bounds.size.height) / 8;
        self.cellWidth = Int(self.bounds.size.width) / 8;
        
        self.board = Board(opening: opening, andType:type, andViewControllerDelegate:viewControllerDelegate);
        
        for cell in self.board.cells {
        
            let cellView:CellView = CellView(
                frame: CGRectMake((CGFloat((cell.column - 1) * self.cellWidth)), CGFloat((8 - cell.row) * self.cellHeight), CGFloat(self.cellWidth), CGFloat(self.cellHeight)), cell:cell as! Cell)
        
            self.addSubview(cellView)
        }
    }
        
    
    func cellViewPressed(cellView:CellView)
    {
        self.board.selectCell(cellView.cell)
        self.draw()
    }
    
    
    func getCellViewForCell(cell:Cell) -> CellView
    {
        let tag:Int = (cell.row * 10) + cell.column;
        return self.viewWithTag(tag) as! CellView
    }
    
    
    
    func draw () {
        for subview in self.subviews {
            if subview is CellView {
                (subview as! CellView).draw();
            }
        }
    }
    
    
    
    
    func highlightHint ()
    {
        self.board.highlightHint()
        self.draw()
    }
    
    
    func step ()
    {
        self.board.simulateMove()
        self.draw()
    }
    
    func play ()
    {
        self.board.startMovesSimulation()
        self.draw()
    }
    
    func stop ()
    {
        self.board.stopMovesSimulation()
        self.draw()
    }

}
