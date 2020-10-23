package bugWorld;

import java.util.ArrayList; 

import info.gridworld.grid.AbstractGrid;
import info.gridworld.grid.Location;

public class SparseBoundedGrid<E> extends AbstractGrid<E> {
	private SparseGridNode[] occupantArray; 
	private int numCols;
	private int numRows;
 
	public SparseBoundedGrid(int rows, int cols){
		 numCols = cols;
		 numRows = rows;
		 occupantArray = new SparseGridNode[rows];
	}
	
	public int getNumRows(){
		 return numRows;
	}
	
	public int getNumCols(){
		 return numCols;
	} 
 
	public boolean isValid(Location loc) {
		if(loc.getRow()<0 || loc.getCol()<0) {
			return false;
		}
		else {
			int maxRow = getNumRows();
			int maxCol = getNumCols();
			return loc.getRow()<maxRow && loc.getCol()<maxCol;
		}
	}
	
	 public ArrayList<Location> getOccupiedLocations() {
		 ArrayList<Location> result = new ArrayList<Location>();
		 int maxRow = getNumRows();
		 for (int r = 0; r < maxRow; r++){
			 for(SparseGridNode head = occupantArray[r]; head!=null; head = head.getNext()) {
				 Location curPos = new Location(r, head.getColumn());
				 result.add(curPos);
			 }
		 }
		 return result;
	 } 
 
	 public E get(Location loc) {
		 if(isValid(loc)==false) {
			 return null;
		 }
		 else {
			 E result = null;
			 for(SparseGridNode head = occupantArray[loc.getRow()]; head!=null; head = head.getNext()) {
				 if(loc.getCol() == head.getColumn()) {
					 result = (E)head.getOccupant(); 
					 break;
				 }
			 }
			 return result;
		 }
	 }
 
	 public E put(Location loc, E obj){
		 if(isValid(loc)==false) {
			 return null;
		 }
		 else {
			 E deleteOne = remove(loc);
			 SparseGridNode nextP = occupantArray[loc.getRow()];
			 occupantArray[loc.getRow()] = new SparseGridNode(obj,loc.getCol(), nextP);
			 return deleteOne;
		 }
	 } 
 
	 public E remove(Location loc) {
		 E obj = get(loc);
		 if (obj == null) { 
			 return null; 
		 }
		 SparseGridNode last = occupantArray[loc.getRow()];
		 if(last != null) {
			 if(last.getColumn() == loc.getCol()) { 
				 occupantArray[loc.getRow()] = last.getNext();
			 }
			 else{
				 SparseGridNode current = last.getNext();
				 while(current!= null && current.getColumn() != loc.getCol()) {
					 last = last.getNext();
					 current = current.getNext();
				 }
				 if(current!=null) last.setNext(current.getNext());
			 }
		 }
		return obj;
	}
}