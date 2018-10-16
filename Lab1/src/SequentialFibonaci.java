
public class SequentialFibonaci {
	public static int fib(int n){
	       
        if ((n==1)||(n==2))
        return 1;
        else
        return fib(n-1)+fib(n-2);
       
    }
        public static long calc(int n)
        {
            long startTime = System.currentTimeMillis();
           
            //System.out.println(fib(n));
           
            long endTime = System.currentTimeMillis();
                    return endTime-startTime;
           
        }
}
