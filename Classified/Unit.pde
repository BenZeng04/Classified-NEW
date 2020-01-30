class Unit extends Card
{
  public static final int CLASS_G = 0, CLASS_H = 1, ELITE = 2, NON_ELITE = 3, TRAVELLER = 4, PROTOTYPE = 5, NOVELTY = 6; // Constants
  public static final int ATTACK = 1, HEALTH = 2, MOVEMENT = 3, RANGE = 4;
  public static final int SAME_PLAYER_EFFECT = -1;
  public ArrayList<Effect> status;
  public boolean canMove;
  public boolean canSpecial;
  public int attackCount;
  public int ATK, HP, MVMT, RNG;
  public int turnPlacedOn;
  private Vector position;
  /* Default constructor for card */
  public Unit() {}
  /* More detailed constructor for card */
  public Unit(String name, String description, int ATK, int HP, int MVMT, int RNG, int cost)
  {
    category = new boolean[CATEGORY_COUNT];
    status = new ArrayList<Effect>();
    this.name = displayName = name;
    this.description = description;
    this.ATK = ATK;
    this.HP = HP;
    this.MVMT = MVMT;
    this.RNG = RNG;
    this.cost = cost;
  }
  /* Getter Method for the private field position. */
  public Vector getPosition() 
  { 
    return position; 
  }
  /* Returns whether or not this card has a given effect. */
  public boolean hasEffect(String s)
  {
    for(Effect e: status) 
      if(e.name.equals(s)) 
        return true;
    /* Default */
    return false;
  }
  /* Adds the given effect to the unit. */
  public void addEffect(Effect ef)
  {
    if(hasEffect("NoEffect")) return;
    if(ef.playerGivenBy == SAME_PLAYER_EFFECT)
      ef.playerGivenBy = playerPosession;
    for(Effect e: status) 
    {
      if(e.name.equals(ef.name)) 
      {
        e.duration = max(ef.duration, e.duration);
        return;
      }
    }
    /* Default */
    status.add(ef);
  }
  /* Override method */
  @Override
  public void modifyStat(int statID, int value) // Directly modified a given card's stat, regardless of effects.
  {
    if(statID == COST)
      cost += value;
    if(statID == ATTACK)
      ATK += value;
    if(statID == HEALTH)
      HP += value;
    if(statID == MOVEMENT)
      MVMT += value;
    if(statID == RANGE)
      RNG += value;
  }
  public void buffStat(int statID, int value) // Takes card override effects into consideration when buffing.
  {
    if(hasEffect("NoEffect"))
      return;
    modifyStat(statID, value);
  }
  public void displayInCollection(Vector at)
  {
  }
  public void displayOnField()
  {
  }
  public void place(Game g, Vector at)
  {
    /* Basic Initialization Process */
    position = at;
    attackCount = 1;
    canMove = true;
    turnPlacedOn = g.p[playerPosession].turnNumber;
    g.startAnimation(new PlaceAnimation(at));
    g.addMove(new Placement(this));
    g.playFieldSelected = at;
    /* Spawn Effects */
    int cntNovelty = 0;
    boolean spawnEffectOpp = name.equals("Jason C") || name.equals("Jefferson") || name.equals("Jawnie Dirp");
    boolean spawnEffectYou = name.equals("George") || name.equals("Anthony");
    ArrayList<Unit> dump = g.fieldAsList();
    if(spawnEffectYou || spawnEffectOpp)
    {
      int validUnitCount = spawnEffectYou? 1: 0;
      for(int i = 0; i < LANES; i++)
        for(int j = 0; j < ROWS; j++)
        {
          if(g.field[i][j] != null && !g.field[i][j].hasEffect("NoEffect") && !samePlayer(g.field[i][j]))
            validUnitCount++;
          if(g.field[i][j] != null && g.field[i][j].category[NOVELTY] && samePlayer(g.field[i][j]))
            cntNovelty++;
        }
      if(validUnitCount >= 1)
        g.abilitySelected = at;
    }
    
    if(name.equals("Jefferson")) ATK++;
    if(name.equals("Megan")) HP = ceil(g.p[playerPosession].HP / 2.0);
    if(name.equals("Mr. Willikens")) ATK += cntNovelty;
    if(name.equals("Mr. Billikens")) HP += cntNovelty;
    if(name.equals("Sharnujan")) { for(Unit u: dump) { if(samePlayer(u) && u.cost >= 4) { RNG += 4; break; } } }
    
    for(Unit u: dump) u.onCardPlaceEvent(this);
    
    
  }
  public void onCardPlaceEvent(Unit u)
  {
  }
  /* General methods that return a list of valid places to go/move/place. */
  public ArrayList<Vector> getValidTiles(Game g)
  {
    ArrayList<Vector> ret = new ArrayList<Vector>();
    for(int i = 0; i < LANES; i++)
    {
      int startingRow = playerPosession == 0? 0: 5;
      if(g.field[i][startingRow] == null) 
        ret.add(new Vector(i, startingRow));
    }
    return ret;
  }
  public ArrayList<Vector> getMoveTiles(Game g)
  {
    ArrayList<Vector> ret = new ArrayList<Vector>();
    int row = position.y + 1;
    while(abs(row - position.y) <= MVMT && row < ROWS && g.field[position.x][row] == null)
      ret.add(new Vector(position.x, row++));
    row = position.y - 1;
    while(abs(row - position.y) <= MVMT && row >= 0 && g.field[position.x][row] == null)
      ret.add(new Vector(position.x, row--));
    if(hasEffect("SideMove"))
    {
      int col = position.x + 1;
      while(abs(col - position.x) <= MVMT && col < LANES && g.field[col][position.y] == null)
        ret.add(new Vector(col++, position.y));
      col = position.x - 1;
      while(abs(col - position.x) <= MVMT && col >= 0 && g.field[col][position.y] == null)
        ret.add(new Vector(col--, position.y));
    }
    return ret;
  }
  public ArrayList<Vector> getAttackTiles(Game g)
  {
    ArrayList<Vector> ret = new ArrayList<Vector>();
    boolean canAttackOver = name.equals("Matthew") || name.equals("Ultrabright");
    int row = position.y + 1;
    while(abs(row - position.y) <= RNG && row < ROWS)
    {
      if(g.field[position.x][row] != null)
      {
        ret.add(new Vector(position.x, row++));
        if(!canAttackOver) 
          break;
      }
    }
    row = position.y - 1;
    while(abs(row - position.y) <= RNG && row >= 0)
    {
      if(g.field[position.x][row] != null)
      {
        ret.add(new Vector(position.x, row--));
        if(!canAttackOver) 
          break;
      }
    }
    int col = position.x + 1;
    while(abs(col - position.x) <= RNG && col < LANES)
    {
      if(g.field[col][position.y] != null)
      {
        ret.add(new Vector(col++, position.y));
        if(!canAttackOver) 
          break;
      }
    }
    col = position.x - 1;
    while(abs(col - position.x) <= RNG && col >= 0)
    {
      if(g.field[col][position.y] != null)
      {
        ret.add(new Vector(col--, position.y));
        if(!canAttackOver) 
          break;
      }
    }
    return ret;
  }
  public ArrayList<Vector> getSpawnEffectTiles(Game g)
  {
    ArrayList<Vector> ret = new ArrayList<Vector>();
    return ret;
  }
  public ArrayList<Vector> getSpecialEffectTiles(Game g)
  {
    ArrayList<Vector> ret = new ArrayList<Vector>();
    return ret;
  }
  private int calculateAdjustedAttack(Game g)
  {
    ArrayList<Unit> dump = new ArrayList<Unit>();
    for(Unit[] array: g.field)
      for(Unit u: array)
        if(u != null) 
          dump.add(u);
    
    int atk = ATK;
    /* Cards which exist in a "Pair", where one card buffs another */
    for(Card c: dump)
    {
      boolean samePlayer = c.playerPosession == playerPosession;
      if(name.equals("Joseph") && c.name.equals("Annika") && samePlayer)
        atk *= 3;
      if(name.equals("A.L.I.C.E.") && c.name.equals("Moonlight") && samePlayer)
        atk *= 2;
      if(name.equals("Ms. Nicke") && c.name.equals("Esther") && samePlayer)
        atk += 7;
      if(name.equals("Ben") && c.category[ELITE] && samePlayer)
        atk++;
    }

    if(hasEffect("2X ATK") || hasEffect("2X ATK (Anny)")) atk *= 2;

    /* Taking into account cards that have an active buff effect */
    if(!hasEffect("NoEffect"))
    {
      for(Unit c: dump)
      {
        boolean samePlayer = c.playerPosession == playerPosession;
        if(c.name.equals("Mandaran") && position.getDistance(c.position) <= 1 && category[NON_ELITE] && samePlayer)
          atk += 3;
        if(c.name.equals("Ben") && category[ELITE] && samePlayer)
          atk += 3;
        if(c.name.equals("Rita") && !samePlayer)
          atk = max(0, atk - 2);
      }
    }
    
    if(turnPlacedOn == g.p[playerPosession].turnNumber && !(name.equals("Joseph") || name.equals("Anny") || name.equals("Tony") || name.equals("Mr. Onosukoo"))) 
      atk >>= 1;
      
    return atk;
  }
  private boolean samePlayer(Unit u) { return u.playerPosession == playerPosession; }
}
