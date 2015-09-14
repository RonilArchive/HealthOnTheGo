package hotg;



import java.io.IOException;
import java.util.logging.Logger;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;

public class Serve extends HttpServlet 
{
    /**
	 * 
	 */
	private static final long serialVersionUID = 2271457894989531419L;
	private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res)
        throws IOException 
        {
    	//System.out.println("Entered Serve.java!!");
    	
    	Logger log = Logger.getLogger(Serve.class.getName());
    		try{
            BlobKey blobKey = new BlobKey(req.getParameter("blob-key"));
            blobstoreService.serve(blobKey, res);
    		}
    		catch(Exception e)
    		{
    			log.warning("Line 36: "+e.getMessage());
    			
    		}
        }
    
}