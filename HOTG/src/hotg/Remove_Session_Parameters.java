package hotg;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Remove_Session_Parameters extends HttpServlet {
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
	
	  response.setContentType("text/html");
	  Logger log = Logger.getLogger(Remove_Session_Parameters.class.getName());
	  
	  try{
      
      String Drug_ID = request.getParameter("drug_id");
      String StrQty = request.getParameter("Qty");
      int Qty=Integer.parseInt(StrQty);
      
     //System.out.println("QTY: "+Qty);
     
      SessionData SD;
      List<SessionData> CartData;
      String CartResponse="";
      
      HttpSession CurrSession = request.getSession();
      CartData=(LinkedList<SessionData>)CurrSession.getAttribute("Cart");
      
      if(CartData!=null){
      for(int i=0;i<CartData.size();i++)
      {   
    	 if(CartData.get(i).Drug_ID.equals(Drug_ID) && CartData.get(i).Item_Qty==Qty)
    	 { 
    		CartData.remove(i);
    		CurrSession.setAttribute("Cart", CartData);
    		 break;
    	 }
      }
      
      
      for(int i=0;i<CartData.size();i++)
      {
      
      	SD=CartData.get(i);
      	
      	CartResponse =CartResponse +"  <div class=\"Shopping-List\"><h1>"+SD.DrugName+"</h1><h2> Mrp: "+SD.MRP+" , "+SD.QtyInStrip+"</h2><button onclick=\"RemoveFromCart('"+SD.Drug_ID+"','"+SD.Item_Qty+"')\">Remove from cart</button><label>Qty: "+SD.Item_Qty+"</label></div> ";
      	
      }
     // System.out.println(CartResponse);
      }
      
      
      response.getWriter().write(CartResponse);
      
      
	  }
	  catch(Exception e)
	  {
		log.severe(e.getMessage());  
		  
	  }
 }	
}
