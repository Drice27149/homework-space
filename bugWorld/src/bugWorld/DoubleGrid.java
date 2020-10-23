package bugWorld;

import info.gridworld.grid.*;
import java.util.ArrayList;
import java.util.*;

public class DoubleGrid<E> extends AbstractGrid<E>{
	 private Object[][] objArray;
	 private int size; 
 
	 public DoubleGrid(){
		 size = 16;
		 objArray = new Object[size][size];;
	 }
	 public int getNumRows(){
		 return -1;
	 }
	 
	 public int getNumCols(){
		 return -1;
	 }

	 public boolean isValid(Location loc){
		 return loc.getRow() >= 0 && loc.getCol() >= 0;
	 } 
 
	 public ArrayList<Location> getOccupiedLocations(){
		 ArrayList<Location> result = new ArrayList<Location>();
		 for (int r = 0; r < size; r++){
			 for (int c = 0; c < size; c++){
				 Location loc = new Location(r, c);
				 if (get(loc) != null) {
					 result.add(loc);
				 }
			 }
		 }
		 return result;
	 }
	 
	 public E get(Location loc){
		 if (!isValid(loc) || loc.getRow() >= size || loc.getCol() >= size) {
			 return null;
		 }
		 else {
			 return (E)objArray[loc.getRow()][loc.getCol()];
		 }
	 }
	 
	 public E put(Location loc, E obj) {
		 if (loc == null || obj==null) {
			 return null;
		 }
		 else {
			 if (loc.getRow() >= size || loc.getCol() >= size)
			 resize(loc);
			 // Add the object to the grid.
			 E deleteOne = get(loc);
			 objArray[loc.getRow()][loc.getCol()] = obj;
			 return deleteOne;
		 }
	 } 
 
	 public E remove(Location loc){
		 if (!isValid(loc) || loc.getRow() >= size || loc.getCol() >= size){
			 return null;
		 }
		 else {
			 E r = get(loc);
			 objArray[loc.getRow()][loc.getCol()] = null;
			 return r;
		 }
	 }

	private void resize(Location loc){
		int origin = size;
		while (loc.getRow() >= size || loc.getCol() >= size) {
			size *= 2;
		}
		Object[][] newArray = new Object[size][size];
		for(int r = 0; r < origin; r++) {
			for(int c = 0; c < origin; c++) {
				newArray[r][c] = objArray[r][c];
			}
		}
		objArray = newArray;
	 }
} 