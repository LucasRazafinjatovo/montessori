<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="finance.*" %>


<%
//System.out.print("aaaaaaaaaaaaaaaaa   idType");
String idEditor=request.getParameter("IdEditor");
Caisse c=new Caisse();
Caisse[] lc=(Caisse[])CGenUtil.rechercher(c,null,null," and idcaisse='"+idEditor+"'");
String cais=lc[0].getEtat();
String ret = "";
if(cais.compareTo("0")==0){
  out.print("<input type='checkbox' name='etat' value='1' checked='checked'/>Rapproche &nbsp; <input type='checkbox' name='etat' value='0'/>Non rapproche");
}
else{
  out.print("<input type='checkbox' name='etat' value='1'/>Rapproche &nbsp; <input type='checkbox' name='etat' value='0'/>Non rapproche");
}
%>



