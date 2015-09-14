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

public class GetCart extends HttpServlet{
	
	
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
		        response.setContentType("text/html");
		        
		        Logger log = Logger.getLogger(GetCart.class.getName());
		        
		try{      
		        
		        SessionData SD;
		        List<SessionData> CartData;
		        String CartResponse="";
	
		        HttpSession CurrSession = request.getSession();
		        if(CurrSession.isNew()){
		        	CartData=new LinkedList<SessionData>();
		        	CurrSession.setAttribute("Cart", CartData);
		        	}
		        else{
		        	CartData=(LinkedList<SessionData>)CurrSession.getAttribute("Cart");   		        	
		        
		        	if(CartData!=null)
		        	for(int i=0;i<CartData.size();i++)
		        		{
		        
		        		SD=CartData.get(i);
		        	
		        		CartResponse =CartResponse +"  <div class=\"Shopping-List\"><h1>"+SD.DrugName+"</h1><h2> Mrp: "+SD.MRP+" , "+SD.QtyInStrip+"</h2><button onclick=\"RemoveFromCart('"+SD.Drug_ID+"',"+SD.Item_Qty+")\">Remove from cart</button><label>Qty: "+SD.Item_Qty+"</label></div> ";
		        	
		        		}
		        	}
		        response.getWriter().write(CartResponse);
		}
		catch(Exception e){
			
			log.severe(e.getMessage());
			
		}
	}
}
