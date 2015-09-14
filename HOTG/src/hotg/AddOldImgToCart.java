package hotg;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;

public class AddOldImgToCart extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    	
    	Logger log = Logger.getLogger(AddOldImgToCart.class.getName());
    	HttpSession CurrSession = request.getSession();
	
    	try{
        	
        	//HttpSession CurrSession = request.getSession();

           // Map<String, BlobKey> blobs = blobstoreService.getUploadedBlobs(request);
        	
        	
     
            	
            	
            	String Drug_ID = GlobalVar.ImageID;
                String Dname = "Uploaded Image";
                String QtyInStrip = "NA";
                String Strength = "NA";
                String PrescriptionFlag="No";
                double MRP =0;
                int Qty=1;
                List<SessionData> CartData;
                
                SessionData SD = new SessionData(Drug_ID,Qty,Dname,MRP,QtyInStrip,Strength,request.getParameter("PresImg"),PrescriptionFlag);
                
                if(CurrSession.isNew() || CurrSession.getAttribute("Cart")==null){
                	CartData=new LinkedList<SessionData>();
                	CartData.add(SD);  //System.out.println("49*****");
                	CurrSession.setAttribute("Cart", CartData);
                	}
                else{
                	CartData=(LinkedList<SessionData>)CurrSession.getAttribute("Cart");   	
                	CartData.add(SD);  //System.out.println("50*****");
                	CurrSession.setAttribute("Cart", CartData);
                	}
            
                response.getWriter().write("Upload Successful. You can now close this window and continue to the next step.");
    	}
            catch(Exception e)
            {
            	 response.getWriter().write("An unexpected error occured. Please try again later.");
            	log.severe(e.getMessage());
            }
	
	

}
    
}
