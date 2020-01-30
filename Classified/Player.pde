class Player 
{
  public ArrayList<Card> hand; 
  public Queue<Card> deck;
  public int turnNumber, HP, cash;
  public boolean canAttack; 
  public Player(int turnNumber, int HP, int cash)
  {
    hand = new ArrayList<Card>();
    deck = new LinkedList<Card>();
    this.turnNumber = turnNumber;
    this.HP = HP;
    this.cash = cash;
  }
  public void drawCard(int cardLimit)
  {
    int countNaturalCards = 0;
    for(Card c: hand)
      if(c.isReal) 
        countNaturalCards++;
    if(deck.size() > 0 && countNaturalCards < cardLimit)
      hand.add(deck.poll());
  }
}
