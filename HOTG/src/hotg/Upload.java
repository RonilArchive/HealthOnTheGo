package hotg;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.google.appengine.api.utils.SystemProperty;

public class Upload extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    	
    	Logger log = Logger.getLogger(Upload.class.getName());
    	String url;
    	HttpSession CurrSession = request.getSession();
    	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	dateFormat.setTimeZone(TimeZone.getTimeZone("IST"));
    	Date date = new Date();
    	
    	 try { 
	        	
	            if (SystemProperty.environment.value() ==
	                SystemProperty.Environment.Value.Production) {
	              // Load the class that provides the new "jdbc:google:mysql://" prefix.
	              Class.forName("com.mysql.jdbc.GoogleDriver");
	              url = "jdbc:google:mysql://healthonthego1503:healthonthego/HOTG?user=root";
	            } else {
	              // Local MySQL instance to use during development.
	          	  Class.forName("com.mysql.jdbc.Driver");
	                url = "jdbc:mysql://127.0.0.1:3306/Mock2?user=Mock";
	            }
	          } catch (Exception e) {
	          	
	            e.printStackTrace();
	            log.warning(e.getMessage());
	           
	            return;
	          }
    	
    	
    	
    	try{
    	
    	//HttpSession CurrSession = request.getSession();

       // Map<String, BlobKey> blobs = blobstoreService.getUploadedBlobs(request);
    	Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(request);
    	
    	List<BlobKey> blobKeyList =  blobs.get("myFile");
    	
    	BlobKey blobKey = blobKeyList.get(0);
    	//BlobKey blobKey = blobs.get("myFile");
        
        
        if (blobKey == null) {
            response.getWriter().write("Failed to upload image. Please try again in some time.");
        } else {
        	
        	
        	String Drug_ID = GlobalVar.ImageID;
            String Dname = "Uploaded Image";
            String QtyInStrip = "NA";
            String Strength = "NA";
            String PrescriptionFlag="No";
            double MRP =0;
            int Qty=1;
            List<SessionData> CartData;
            
            SessionData SD = new SessionData(Drug_ID,Qty,Dname,MRP,QtyInStrip,Strength,blobKey.getKeyString(),PrescriptionFlag);
            
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
            
            String LoggedInUserID=(String)CurrSession.getAttribute("UserIDLogin");
           
         if(LoggedInUserID!=null)
         {
            	try {
		            java.sql.Connection conn = DriverManager.getConnection(url);
		            try {
		            	 String statement = "INSERT INTO User_Prescription_Mapping (User_Id,Upload_Key,Timestamp) values (?,?,?)";
		                 
		                 PreparedStatement stmt = conn.prepareStatement(statement);
		                 
		                 stmt.setString(1, LoggedInUserID);
		                 stmt.setString(2, blobKey.getKeyString());
		                 stmt.setString(3, dateFormat.format(date));
		                 
		                 int success = stmt.executeUpdate();
		                 
		                 
		            }
		            catch(SQLException s){
		            	
		            	log.warning("Line 146:"+s.getMessage());
		            	
		            }
		            catch (Exception f) {
		                
		                log.warning("Line 154:"+f.getMessage());              
		                
		              }
		            finally {
		              conn.close();
		            }
		          } catch (SQLException e) {
		             
		            log.warning("Line 164:"+e.getMessage());
		          }
            	
            }
          
        	
        	response.getWriter().write("Upload Successful. You can now close this window and continue to the next step.");
        	
        }
    }
    catch(Exception e)
    {
    	log.severe(e.getMessage());
    }	
    
  }
}