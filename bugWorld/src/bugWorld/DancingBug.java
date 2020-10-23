package bugWorld;
import info.gridworld.actor.Bug;

/**
 * A <code>BoxBug</code> traces out a square "box" of a given size. <br />
 * The implementation of this class is testable on the AP CS A and AB exams.
 */
public class DancingBug extends Bug
{
    private int steps;
    private int pointer;
    private int[] sequence;
    /**
     * Constructs a box bug that traces a square of a given side length
     * @param length the side length
     */
    public DancingBug(int []array)
    {
    	sequence = array;
        steps = 0;
        pointer = 0;
    }

    /**
     * Moves to the next location of the square.
     */
    public void act()
    {
        if(steps<sequence[pointer] && canMove()) {
        	move();
        	steps += 1;
        }
        else
        {
            turn();
            steps = 0;
            pointer = (pointer+1)%sequence.length;
        }
    }
}