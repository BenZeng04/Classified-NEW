class Game
{
  public Player[] p = new Player[2];
  public Unit[][] field = new Unit[LANES][ROWS];
  public Vector playFieldSelected = null, abilitySelected = null;
  public int cardSelected = -1;
  public void startAnimation(Animation a)
  {
  }
  public void addMove(Move m)
  {
  }
  public void displayField()
  {
  }
  public ArrayList<Unit> fieldAsList()
  {
    ArrayList<Unit> dump = new ArrayList<Unit>();
    for(int i = 0; i < LANES; i++)
      for(int j = 0; j < ROWS; j++)
        if(field[i][j] != null)
          dump.add(field[i][j]);
    return dump;
  }
}
