package bugWorld;

import info.gridworld.actor.Bug;

/**
 * A <code>BoxBug</code> traces out a square "box" of a given size. <br />
 * The implementation of this class is testable on the AP CS A and AB exams.
 */
public class ZBug extends Bug
{
    private int steps;
    private int sideLength;
    private int state;
    
    /**
     * Constructs a box bug that traces a square of a given side length
     * @param length the side length
     */
    public ZBug(int length)
    {
    	while(getDirection()!=90) turn();
    	state = 0;
        steps = 0;
        sideLength = length;
    }

    /**
     * Moves to the next location of the square.
     */
    public void act()
    {
        if (steps < sideLength && canMove())
        {
            move();
            steps++;
        }
        else
        {
        	if(state==0) {
        		for(int i = 0; i < 3; i++) {
        			turn();
        		}
        		state++;
        		steps = 0;
        	}
        	else if(state==1) {
        		for(int i = 0; i < 5; i++) {
        			turn();
        		}
        		state++;
        		steps = 0;
        	}
        	else {
        		//stop
        	}
        }
    }
}
