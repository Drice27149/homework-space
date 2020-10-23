package bugWorld;

import java.util.ArrayList; 

import info.gridworld.actor.Actor;
import info.gridworld.grid.Location;


public class KingCrab extends CrabCritter{

	public KingCrab(){}
	
	int abs(int u) {
		return u>0?u:-u;
	}
	
	public boolean canMoveOne(Actor a){
		ArrayList<Location> locs = getGrid().getEmptyAdjacentLocations(a.getLocation());
		for(Location loc:locs){
			int dis = abs(loc.getCol()-getLocation().getCol())+abs(loc.getRow()-getLocation().getRow());
			if(dis==2){
				a.moveTo(loc);
				return true;
			}
		}
		return false;
	}
	
	public void processActors(ArrayList<Actor> actors){
		for (Actor a : actors){
			if(!canMoveOne(a)){
				a.removeSelfFromGrid();
			}
		}
	}
}
 
