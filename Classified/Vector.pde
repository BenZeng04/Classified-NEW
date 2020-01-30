class Vector
{
  public int x, y;
  public Vector(int x, int y) {this.x = x; this.y = y;}
  public int getDistance(Vector to) { return max(abs(x - to.x), abs(y - to.y)); }
}
