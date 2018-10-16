
public class Unsynced{
	static public Integer x;
	static public long calc()
	{
		long startTime = System.currentTimeMillis();
		x=0;
		Thread t1 = new Thread() {
			public void run()
			{
				for(int i = 0;i<100000;i++)
				{
					x+=1;
				}
			}
		};
		Thread t2 = new Thread() {
			public void run()
			{
				for(int i = 0;i<100000;i++)
				{
					if(i%2==0)
						x*=2;
					else
						x/=2;
				}
			}
		};
		Thread t3 = new Thread() {
			public void run()
			{
				for(int i = 0;i<100000;i++)
				{
					x-=1;
				}
			}
		};
		t1.start();
		t2.start();
		t3.start();
		try {
			t1.join();
			t2.join();
			t3.join();
		}
		catch(Exception e) {}
		long endTime = System.currentTimeMillis();
		return endTime-startTime;
	}
}
