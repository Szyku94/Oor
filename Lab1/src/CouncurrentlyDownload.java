import java.awt.Image;
import java.io.IOException;
import java.net.URL;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

import javax.imageio.ImageIO;

public class CouncurrentlyDownload {
	@SuppressWarnings("unused")
	public static long download()
	{
		long startTime = System.currentTimeMillis();
		ExecutorService es = Executors.newCachedThreadPool();
		for(int i=0;i<10;i++)
		    es.execute(new Runnable() {
		    	public void run()
		    	{
		    		Image image = null;
		    		try {
		    		    URL url = new URL("https://picsum.photos/200");
		    		    image = ImageIO.read(url);
		    		} catch (IOException e) {
		    		}
		    	}
		    });
		es.shutdown();
		try {
			boolean finshed = es.awaitTermination(1, TimeUnit.MINUTES);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		long endTime = System.currentTimeMillis();
		return endTime-startTime;
	}
}
