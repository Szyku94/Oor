
public class Main {
	public static void main(String[] args)
	{
		Synced.calc();
		System.out.println("Synchronizowana: "+Synced.calc()+" ms\n"+Synced.x);
		
		System.out.println("Niesynchronizowana: "+Unsynced.calc()+" ms\n"+Unsynced.x);
		
	}
}
