class Effect
{
  public int duration;
  public int playerGivenBy;
  public String name;
  public Effect(String name, int duration) { this.name = name; this.duration = duration; playerGivenBy = Unit.SAME_PLAYER_EFFECT; }
  public Effect(String name, int duration, int playerGivenBy) { this.name = name; this.playerGivenBy = playerGivenBy; this.duration = duration; }
  public void displayEffect(Vector at)
  {
  }
}
