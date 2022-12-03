<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>


<%
//System.out.print("aaaaaaaaaaaaaaaaa   idType");
String idEditor=request.getParameter("IdEditor");
System.out.println(idEditor);
Vendeur crt=new Vendeur();
crt.setIdplace(idEditor);

Vendeur[]reponse=(Vendeur[])CGenUtil.rechercher(crt,null,null," and idplace='"+idEditor+"' order by surnom");
String ret = "";
if(reponse.length!=0){
%>
<%
	for(int i=0;i<reponse.length;i++){

	  //out.print("<item id='"+reponse[i].getId()+"' name='"+reponse[i].getSurnom()+"'/>");
	  ret+="<option value='"+reponse[i].getId()+"'>"+reponse[i].getSurnom()+"</option>";
	}
}
out.print(ret);
%>
