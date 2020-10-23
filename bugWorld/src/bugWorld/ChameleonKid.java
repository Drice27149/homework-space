package bugWorld;

import java.util.ArrayList;

import info.gridworld.actor.Actor; 
import info.gridworld.grid.Location; 
import info.gridworld.grid.Grid;


public class ChameleonKid extends ChameleonCritter{
	
	public ArrayList<Actor> getActors(){
		ArrayList<Actor> actors = new ArrayList<Actor>(); 
		for (Location loc: getUpAndDownLoc()) {
			Actor a = getGrid().get(loc); 
			if (a != null) {
				actors.add(a);
			}
		}
		return actors;
	}
	
	public ArrayList<Location> getUpAndDownLoc(){
	  ArrayList<Location> locs = new ArrayList<Location>();
	  Grid<Actor> grid = getGrid();
	  Location loc = getLocation();
	  int offset[] = {0,180};
	  for (int x: offset){
		  Location pos = loc.getAdjacentLocation(getDirection() + x); 
		  if (grid.isValid(pos)) {
			  locs.add(pos); 
		  }
	  }
	  return locs;
	}
}
