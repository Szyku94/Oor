
public class Main {
	public static void main(String args[])
	{
		System.out.println("Sekwencyjne pobieranie: "+SequentialDownload.download()+" ms");
		System.out.println("Równoległe pobieranie: "+CouncurrentlyDownload.download()+" ms");
		System.out.println("Sekwencyjny Fibonacci: "+SequentialFibonaci.calc(20)+" ms");
		System.out.println("Równoległy Finbonacci: "+ConcurrentlyFibonaci.calc(20)+" ms");
	}
}