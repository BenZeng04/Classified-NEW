abstract class Card
{
  /* Card Stats */
  public static final int COST = 0;
  public String name;
  public String displayName;
  public String description;
  public int cost;
  public int playerPosession;
  public boolean isReal;
  public boolean[] category; // What categories this card is part of.
  public void modifyStat(int statID, int value) 
  {
    if(statID == COST)
      cost += value;
  }
  public abstract ArrayList<Vector> getValidTiles(Game g);
  public abstract void place(Game g, Vector at);
  public abstract void displayInCollection(Vector at);
}
