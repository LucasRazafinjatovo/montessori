<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facture.*" %>
<%@ page import="affichage.*" %>


<%
//System.out.print("aaaaaaaaaaaaaaaaa   idType");
String idEditor=request.getParameter("IdEditor");

int ret = -1;
if(idEditor!=null || idEditor.compareToIgnoreCase("")!=0){
  FactureMereProforma crt=new FactureMereProforma();
  System.out.println("idEditor:"+idEditor);
  FactureMereProforma[]reponse=(FactureMereProforma[])CGenUtil.rechercher(crt,null,null," and idclient = '"+idEditor+"' order by datelimitepaiement desc,reduction desc");
  if(reponse.length!=0){
%>
<%
  ret = reponse[0].getReduction();
  }
}
out.print(ret);

%>
