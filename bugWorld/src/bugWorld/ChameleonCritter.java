package bugWorld;

import java.awt.Color;
import java.util.ArrayList;

import info.gridworld.actor.Actor;
import info.gridworld.actor.Critter;

public class ChameleonCritter extends Critter{
	
	public void processActors(ArrayList<Actor> actors){
		int n = actors.size(); 
		if (n == 0) {
			darken();
		}
		else {
			int rand = (int) (Math.random() * n); 
			Actor other = actors.get(rand); 
			setColor(other.getColor());
		}
	}
	
	private void darken(){
		Color c = getColor();
		double rate = 0.5;
		int red = (int) (c.getRed() * (1 - rate));
		int green = (int) (c.getGreen() * (1 - rate)); 
		int blue = (int) (c.getBlue() * (1 - rate));
		setColor(new Color(red, green, blue));
	}
}
