package bugWorld;

import info.gridworld.actor.Actor;
import info.gridworld.actor.ActorWorld;
import info.gridworld.actor.Bug;
import info.gridworld.actor.Critter;
import info.gridworld.actor.Rock;
import info.gridworld.grid.BoundedGrid;
import info.gridworld.grid.Location;
import info.gridworld.grid.UnboundedGrid;
import info.gridworld.world.World;

public class BugRunner {
	public static void main(String[] args) {
		int dx[] = new int[] {-1,1,0,0};
		int dy[] = new int[] {0,0,-1,1};
		ActorWorld world = new ActorWorld();
		world.addGridClass("bugWorld.SparseBoundedGrid");
		world.addGridClass("bugWorld.DoubleGrid");
		//world.setGrid(new BoundedGrid<Actor>(20,20));
		//world.setGrid(new UnboundedGrid<Actor>());
		Location location0 = new Location(15,15);
		Location location1 = new Location(10, 10);
		world.add(new Location(2, 2), new Bug());
		//start
		world.show();
	}
}

//for xxxBug
/*
CircleBug circleBug = new CircleBug(5);	
world.add(location0,circleBug);

SpiralBug spiralBug = new SpiralBug(3);
world.add(location0,spiralBug);

ZBug zBug = new ZBug(5);
world.add(location,zBug);

int[] array = new int[] {1,5,1,5,1};
DancingBug dancingBug = new DancingBug(array);
world.add(location,dancingBug);

Jumper jumper = new Jumper();
world.add(location1,jumper);
 */

//for xxxCritter
/*
ChameleonCritter chameleonCritter = new ChameleonCritter();
world.add(location0, chameleonCritter);
for(int i = 0; i < 4; i++) {
	int dr = dx[i], dc = dy[i];
	world.add(new Location(location0.getRow()+dr, location0.getCol()+dc), new Bug());
}

ChameleonKid chameleonKid = new ChameleonKid();
world.add(location0, chameleonKid);
for(int i = 2; i < 4; i++) {
	int dr = dx[i], dc = dy[i];
	world.add(new Location(location0.getRow()+dr, location0.getCol()+dc), new Bug());
}

RockHound rh = new RockHound();
world.add(location0, rh);
for(int i = 0; i < 2; i++) {
	int dr = dx[i], dc = dy[i];
	world.add(new Location(location0.getRow()+dr, location0.getCol()+dc), new Bug());
}
for(int i = 2; i < 4; i++) {
	int dr = dx[i], dc = dy[i];
	world.add(new Location(location0.getRow()+dr, location0.getCol()+dc), new Rock());	
}

BlusterCritter bc = new BlusterCritter(4 dark/5 light);
world.add(location0, bc);
for(int i = 0; i < 4; i++) {
	int dr = dx[i], dc = dy[i];
	world.add(new Location(location0.getRow()+dr, location0.getCol()+dc), new Critter());
}

QuickCrab qc = new QuickCrab();
world.add(location0, qc);

//left front, front, or right front
KingCrab kc = new KingCrab();
world.add(location0, kc);
for(int i = 0; i < 4; i++) {
	int dr = dx[0], dc = dy[i];
	world.add(new Location(location0.getRow()+dr, location0.getCol()+dc), new Rock());
}
int dr = -2;
int dc = 0;
world.add(new Location(location0.getRow()+dr, location0.getCol()+dc), new Rock());
*/
