<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>


<%
//System.out.print("aaaaaaaaaaaaaaaaa   idType");
String idEditor=request.getParameter("IdEditor");
System.out.println(idEditor);
Rubrique crt=new Rubrique();
crt.setJournal(idEditor);

Rubrique[]reponse=(Rubrique[])CGenUtil.rechercher(crt,null,null," and journal='"+idEditor+"' order by libelle");
String ret = "";
if(reponse.length!=0){
%>
<%
for(int i=0;i<reponse.length;i++){

  //out.print("<item id='"+reponse[i].getId()+"' name='"+reponse[i].getSurnom()+"'/>");
  ret+="<option value='"+reponse[i].getLibelle()+"'>"+reponse[i].getLibelle()+"</option>";
}
}
out.print(ret);
%>
