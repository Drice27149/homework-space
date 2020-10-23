package bugWorld;

public class SparseGridNode {
	private Object occupant;
	private int col;
	private SparseGridNode next;

	public SparseGridNode(Object occ, int colNum,SparseGridNode initNext){
		occupant = occ;
		col = colNum;
		next = initNext;
	}

	public Object getOccupant(){
		return occupant;
	}

	public int getColumn(){
		return col;
	}
	
	public SparseGridNode getNext(){
		return next;
	}

	public void setOccupant(Object occ){
	 occupant = occ;
	}

	public void setNext(SparseGridNode newNext){
		next = newNext;
	}
} 