package bugWorld;

import java.util.ArrayList;
import java.awt.Color;

import info.gridworld.actor.Actor;
import info.gridworld.actor.Critter;
import info.gridworld.grid.Location;


public class BlusterCritter extends Critter{
	private int courage;
	
	public BlusterCritter(int c){
		courage = c;
	} 
	
	private int abs(int u) {
		return u>0?u:-u;
	}
	
	public ArrayList<Actor> getActors(){
		ArrayList<Actor> actors = new ArrayList<Actor>();
		Location loc = getLocation();
		for(int dr = -2; dr <= 2; dr++ ) {
			for(int dc = -2; dc <= 2; dc++){
				if(abs(dr)+abs(dc)<=2 && abs(dr)+abs(dc)>0) {
					int r = loc.getRow()+dr, c = loc.getCol()+dc;
					Location nextLoc = new Location(r,c);
					if(getGrid().isValid(nextLoc)){
						Actor object = getGrid().get(nextLoc);
						if(object != null) {
							actors.add(object);
						}
					}
				}
			}
		}
		return actors;
	} 
	
	private void darken(){
		Color c = getColor();
		double rate = 0.5;
		int red = (int) (c.getRed() * (1 - rate));
		int green = (int) (c.getGreen() * (1 - rate)); 
		int blue = (int) (c.getBlue() * (1 - rate));
		setColor(new Color(red, green, blue));
	}
	
	private int min(int a,int b) {
		return a>b?b:a;
	}
	
	private void lighten() {
		Color c = getColor();
		int red = c.getRed();
		int green = c.getGreen();
		int blue = c.getBlue();
		red = min(255, red+1);
		green = min(255, green+1);
		blue = min(255, blue+1);
		setColor(new Color(red, green, blue));
	} 
	
	public void processActors(ArrayList<Actor> actors){
		int total = 0;
		for(Actor a: actors) {
			if(a instanceof Critter) {
				total++;
			}
		}
		if(total < courage) {
			lighten();
		}
		else {
			darken();
		}
	 } 
}