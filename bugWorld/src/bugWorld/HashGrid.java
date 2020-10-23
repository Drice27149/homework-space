package bugWorld;

import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

import info.gridworld.grid.AbstractGrid;
import info.gridworld.grid.Grid;
import info.gridworld.grid.Location;

/**
 * An <code>UnboundedGrid</code> is a rectangular grid with an
 * unbounded number of rows and columns. <br />
 * The implementation of this class is testable on the AP CS AB Exam.
 */
public class HashGrid<E> extends AbstractGrid<E> {
	 private Map<Location, E> myMap;
	 private int numRows;
	 private int numCols;

	 public HashGrid(int rows, int cols) {
		 myMap = new HashMap<Location, E>();
		 numRows = rows;
		 numCols = cols;
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
	 
	 public ArrayList<Location> getOccupiedLocations(){
		 ArrayList<Location> result = new ArrayList<Location>();
		 for (Location loc : myMap.keySet()) {
			 result.add(loc);
		 }
		 return result;
	 }
	 
	 public E get(Location loc) {
		 if (loc == null) {
			 return null;
		 }
		 else {
			 return myMap.get(loc);
		 }
	 }
	 
	 public E put(Location loc, E obj) {
		 if (loc == null || obj == null) {
			 return null;
		 }
		 else {
			 return myMap.put(loc, obj);
		 }
	 }
	 
	 public E remove(Location loc){
		 if (loc == null) {
			 return null;
		 }
		 else {
			 return myMap.remove(loc);
		 }
	 }
} 