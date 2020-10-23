package bugWorld;

import java.util.ArrayList;

import info.gridworld.actor.Actor;
import info.gridworld.grid.Grid;
import info.gridworld.grid.Location;


public class QuickCrab extends CrabCritter {
	public QuickCrab(){}
	
	public ArrayList<Location> getMoveLocations() {
		ArrayList<Location> locs = new ArrayList<Location>();
		addIfGoodTwoAwayMove(locs,getDirection() + Location.LEFT);
		addIfGoodTwoAwayMove(locs,getDirection() + Location.RIGHT);
		if (locs.size() == 0) {
			return super.getMoveLocations();
		}
		else return locs;
	 }

	 private void addIfGoodTwoAwayMove(ArrayList<Location> locs,int d) {
		 Grid<Actor> grid = getGrid();
		 Location loc = getLocation();
		 Location nextPos = loc.getAdjacentLocation(d);
		 if(grid.isValid(nextPos) && grid.get(nextPos) == null) {
			 Location nextTwo = nextPos.getAdjacentLocation(d);
			 if(grid.isValid(nextTwo) && grid.get(nextTwo)== null) {
				 locs.add(nextTwo);
			 }
		 }
	 }
}