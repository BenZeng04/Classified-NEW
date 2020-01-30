class SingleTargetSpell extends Card
{
  private Vector target;
  public boolean targetsUser;
  /* Default constructor for card */
  public SingleTargetSpell() {}
  /* More detailed constructor for card */
  public SingleTargetSpell(String name, String description, boolean targetsUser, int cost)
  {
    category = new boolean[CATEGORY_COUNT];
    this.name = displayName = name;
    this.description = description;
    this.cost = cost;
    this.targetsUser = targetsUser;
  }
  public ArrayList<Vector> getValidTiles(Game g)
  {
    ArrayList<Vector> ret = new ArrayList<Vector>();
    for(int i = 0; i < LANES; i++)
    {
      for(int j = 0; j < ROWS; j++)
      {
        Unit u = g.field[i][j];
        if(u == null) continue;
        boolean sameUser = playerPosession == u.playerPosession;
        if(sameUser == targetsUser && checkIfValidCard(u))
          ret.add(new Vector(i, j));
      }
    }
    return ret;
  }
  public void place(Game g, Vector at)
  {
  }
  public void setTarget(int x, int y) { target = new Vector(x, y); }
  private boolean checkIfValidCard(Unit u)
  {
    if(u.hasEffect("NoEffect")) 
      return false;
    return true;
  }
}

class MultiTargetSpell extends Card
{
  /* Default constructor for card */
  public MultiTargetSpell() {}
  /* More detailed constructor for card */
  public MultiTargetSpell(String name, String description, int cost)
  {
    category = new boolean[CATEGORY_COUNT];
    this.name = displayName = name;
    this.description = description;
    this.cost = cost;
  }
  public ArrayList<Vector> getValidTiles(Game g)
  {
    ArrayList<Vector> ret = new ArrayList<Vector>();
    ret.add(null);
    return ret;
  }
  public void place(Game g, Vector at)
  {
  }
}
