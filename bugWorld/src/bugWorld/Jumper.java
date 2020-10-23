package bugWorld;

import info.gridworld.actor.Actor;
import info.gridworld.actor.Flower;
import info.gridworld.actor.Rock;
import info.gridworld.grid.Grid;
import info.gridworld.grid.Location;

public class Jumper extends Actor{
	
	public Jumper() {
		
	}
	
	public void act() {
		if(canJump()) {
			jump();
		}
		else {
			turn();
		}
	}
	
	public void turn() {
		setDirection(getDirection() + Location.HALF_RIGHT);
	}
	
	public boolean canJump() {
		Grid<Actor> grid = getGrid();
		Location pos = getLocation();
		Location nextOne = pos.getAdjacentLocation(getDirection());
		Location nextTwo = nextOne.getAdjacentLocation(getDirection());
		if(grid.isValid(nextOne) && grid.isValid(nextTwo)) {
			Actor actorOne = grid.get(nextOne);
			if(actorOne==null || actorOne instanceof Rock || actorOne instanceof Flower) {
				Actor actorTwo = grid.get(nextTwo);
				if(actorTwo==null || actorTwo instanceof Flower) {
					return true;
				}
			}
		}
		return false;
	}
	
	public void jump() {
		Location pos = getLocation();
		Location nextOne = pos.getAdjacentLocation(getDirection());
		Location nextTwo = nextOne.getAdjacentLocation(getDirection());
		moveTo(nextTwo);
	}
}
