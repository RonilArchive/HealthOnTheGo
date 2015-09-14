package hotg;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.appengine.api.utils.SystemProperty;
import com.google.cloud.sql.jdbc.Connection;
import com.google.cloud.sql.jdbc.ResultSet;
import com.google.cloud.sql.jdbc.Statement;


public class Add_Session_Parameters extends HttpServlet {
	  
    /**
	 * 
	 */
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html");
        Logger log = Logger.getLogger(Add_Session_Parameters.class.getName());
        
  try{      
        
        String Drug_ID = request.getParameter("drug_id");
        String Item_Qty = request.getParameter("item_qty");
        String Dname = request.getParameter("DName");
        String QtyInStrip = request.getParameter("QtyInStrip");
        String Strength = request.getParameter("Strength");
        String PrescriptionFlag = request.getParameter("PrescriptionFlag");
        
        double MRP = Double.parseDouble(request.getParameter("MRP"));
        int Qty=Integer.parseInt(Item_Qty);
        if(Qty<=0){Qty=1;}
        SessionData SD = new SessionData(Drug_ID,Qty,Dname,MRP,QtyInStrip,Strength,null,PrescriptionFlag);
        List<SessionData> CartData;
        String CartResponse="";
        
       //System.out.println("11*****");
        
        HttpSession CurrSession = request.getSession();
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
     
       // System.out.println("2*****");
        
        
        for(int i=0;i<CartData.size();i++)
        {
        
        	SD=CartData.get(i);
        	
        	CartResponse =CartResponse +"  <div class=\"Shopping-List\"><h1>"+SD.DrugName+"</h1><h2> Mrp: "+SD.MRP+" , "+SD.QtyInStrip+"</h2><button onclick=\"RemoveFromCart('"+SD.Drug_ID+"','"+SD.Item_Qty+"')\">Remove from cart</button><label>Qty: "+SD.Item_Qty+"</label></div> ";
        	//System.out.println("3*****");
        }//System.out.println("4*****");
        
        
        
        
        


 //      String cart_data ="  <div class=\"Shopping-List\"><h1>CROCIN(650 mg)</h1><h2> 14 tablets in strip, Qty:200gm, Mrp:10.00 </h2><button>Remove from cart</button><label>Qty: 2</label></div> ";

       response.getWriter().write(CartResponse);

  		}
  		catch(Exception e){
  			log.severe(e.getMessage());
  		}
	}
}


