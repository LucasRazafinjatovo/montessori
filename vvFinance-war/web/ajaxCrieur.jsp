<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>


<%
String idEditor = request.getParameter("IdEditor");
System.out.println(idEditor);
Vendeur crt = new Vendeur();
crt.setNomTable("crieur");
crt.setGrossiste(idEditor);

Vendeur[]reponse =(Vendeur[])CGenUtil.rechercher(crt,null,null," and grossiste like '%"+idEditor+"%' order by surnom");
String ret = "";
if(reponse.length!=0){
	%>
	<%
	for(int i=0;i<reponse.length;i++){
		ret+="<option value='"+reponse[i].getId()+"'>"+reponse[i].getSurnom()+"</option>";
	}
}
out.print(ret);
%>
