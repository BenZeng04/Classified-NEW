abstract class Move
{
  public abstract void perform(Game g);
}
class Placement extends Move
{
  public Unit placed;
  public Placement(Unit u) { placed = u; }
  public void perform(Game g)
  {
  }
  
}
