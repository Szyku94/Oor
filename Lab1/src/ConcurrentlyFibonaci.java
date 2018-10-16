
public class ConcurrentlyFibonaci extends Thread{
	public int x;
	public int result;
	public ConcurrentlyFibonaci(int x)
	{
		this.x=x;
	}
	public void  run(){
	       
        if ((x==1)||(x==2))
        result = 1;
        else
        {
        	ConcurrentlyFibonaci fib1 = new ConcurrentlyFibonaci(x-1);
        	ConcurrentlyFibonaci fib2 = new ConcurrentlyFibonaci(x-2);
        	
        	fib1.start();
        	fib2.start();
        	try {
            	fib1.join();
            	fib2.join();
        	}
        	catch(Exception e)
        	{
        		
        	}
        	result = fib1.result+fib2.result;
        	
        }
    }
        public static long calc(int n)
        {
            long startTime = System.currentTimeMillis();
            ConcurrentlyFibonaci fib = new ConcurrentlyFibonaci(n);
            fib.start();
            try {
				fib.join();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
            //System.out.println(fib.result);
           
            long endTime = System.currentTimeMillis();
                    return endTime-startTime;
           
        }
}
