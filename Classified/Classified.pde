import java.util.*;
import java.io.*;

final HashMap<String, Effect> DEFAULT_EFFECTS = new HashMap<String, Effect>() {{
    put("Jefferson", new Effect("NoEffect", -1));
    put("Mr. Ustenglibo", new Effect("NoEffect", -1));
    put("Lina", new Effect("HealDisable", -1));
    put("Tony", new Effect("Alive", 3));
    put("Joseph", new Effect("Alive", 3));
    put("Physouie", new Effect("Alive", 3));
    put("Mr. Farewell", new Effect("Alive", 3));
    put("Snake", new Effect("Alive", 3));
    put("Mr. Onosukoo", new Effect("Alive", 1));
    put("Kevin", new Effect("Resurrect", -1));
    put("Ilem", new Effect("Resurrect", -1));
    put("Anny", new Effect("2X ATK (Anny)", 2));
    put("Lucy", new Effect("GetsBuffed", -1));
}};
final HashSet<String> SPECIAL_MOVE = new HashSet<String>() {{
    add("Ethan");
    add("Hubert");
    add("Ms. Iceberg");
    add("Neil");
}};
final int LANES = 5, ROWS = 6;
final int CATEGORY_COUNT = 7, CARD_COUNT = 100;
final int MAIN_MENU = 0, P1_DECK_SELECTION = 1, P2_DECK_SELECTION = 2, SETTINGS = 3, INSTRUCTIONS = 4, CREDITS = 5, GAMEPLAY = 6, TURN_SWITCHING = 7, REPLAY = 8, P1_VICTORY = 9, P2_VICTORY = 10;
int mode = MAIN_MENU;
Card[] collection = new Card[CARD_COUNT];

void setup()
{
  // Basic Initialization
  size(1200, 800);
  textFont(loadFont("SegoeUI-Bold-48.vlw"));
  // Collection Initialization
  BufferedReader br = createReader("Collection.txt");
  Queue<Card>[] buckets = new Queue[CATEGORY_COUNT + 1];
  for(int i = 0; i <= CATEGORY_COUNT; i++) 
    buckets[i] = new LinkedList<Card>();
 
  try
  {
    for(int i = 0; i < CARD_COUNT; i++)
    {
      String[] decode = br.readLine().split("/");
      if(decode[1].equals("card"))
      {
        int[] stats = int(decode[3].split(" "));
        int[] categories = int(decode[5].split(" "));
        int maxCategory = 0;
        Unit u = new Unit(decode[2], decode[4], stats[0], stats[1], stats[2], stats[3], stats[4]);
        for(int category: categories)
        {
          maxCategory = max(maxCategory, category);
          u.category[category] = true;
        }
        buckets[maxCategory].add(u);
      } 
      else if(decode[5].equals("targetsAll"))
      {
        MultiTargetSpell mts = new MultiTargetSpell(decode[2], decode[4], int(decode[3]));
        buckets[CATEGORY_COUNT].add(mts);
      }
      else
      {
        SingleTargetSpell sts = new SingleTargetSpell(decode[2], decode[4], decode[5] == "You", int(decode[3]));
        buckets[CATEGORY_COUNT].add(sts);
      }
    }
  }
  catch(IOException e) {}
  int ptr = 0;
  for(Queue<Card> Q: buckets)
  {
    while(!Q.isEmpty())
      collection[ptr++] = Q.poll();
  }
}

void mousePressed()
{
  if(mode == GAMEPLAY)
  {
    
  }
}
