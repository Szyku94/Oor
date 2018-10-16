import java.awt.Image;
import java.io.IOException;
import java.net.URL;

import javax.imageio.ImageIO;

public class SequentialDownload {
	@SuppressWarnings("unused")
	public static long download()
	{
		long startTime = System.currentTimeMillis();
		Image image = null;
		for(int i=0;i<10;i++)
		{
			try {
			    URL url = new URL("https://picsum.photos/200");
			    image = ImageIO.read(url);
			} catch (IOException e) {
			}
		}
		long endTime = System.currentTimeMillis();
		return endTime-startTime;
	}
}
