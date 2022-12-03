<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresFactureInit.jsp";
        String lien= null;
        UserEJB u = null;
        Change ch[] = null;
        int pazy=0;
        int nbParPazy=Parametre.getNbParPage();
%>
<%
pazy=Utilitaire.stringToInt(request.getParameter("pazy"));
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
ch = u.findChange("%","%","");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>

<link href="style.css" rel="stylesheet" type="text/css">
<h1>Historique change </h1>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center"> <table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
        <tr class="head">
          <td width="14%" height="20"><div align="center"><strong>Date d&eacute;but
              validit&eacute; </strong></div></td>
          <td width="12%"><div align="center">Devise</div></td>
          <td width="12%"><div align="center"><strong>Valeur en Ariary</strong></div></td>
        </tr>
       <%
int pejy=0;
if(pazy==0){
        pejy=0;
        pazy=1;
}else{
        pejy=pazy-1;
}
int pazy1=nbParPazy*pejy;
int pazy2=pazy*nbParPazy;
if(pazy2>ch.length){
  pazy2=ch.length;
}
%>
   <%
  for(int i=pazy1;i<pazy2;i++){
  %>
        <tr>
          <td height="20"><div align="center"><%=Utilitaire.formatterDaty(ch[i].getDatydebutvalid())%></div></td>
          <td><div align="center"><%=u.findTypeObjet("Devise",ch[i].getIdDevise(),"%")[0].getVal()%></div></td>
          <td><div align="center"><%=ch[i].getValeurEnAriary()%></div></td>
        </tr>
        <%
  }
  %>
      </table></td>
  </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
<tr><td height="25"><b>Nombre de r&eacute;sultat :</b> <%=ch.length%></td><td align="right"><%if(ch.length!=0){%><strong>page</strong> <%=pazy%> <b>sur</b> <%if(ch.length%nbParPazy==0)out.println(ch.length/nbParPazy);else out.println(ch.length/nbParPazy+1);}%></td></tr>
    <tr>
    <td width="295" valign="top" height="25">
<%if(pazy!=1){%>
        <a href="<%=lien%>?but=facture/ch.jsp">&lt;&lt;Page
      pr&eacute;c&eacute;dente</a>
<%

}
 pazy=pazy+1;
  %></td>
    <td width="305" align="right" valign="top">
      <%
      if(ch.length>pazy2){
      %>
      <a href="<%=lien%>?but=facture/listeChange.jsp">Page
      suivante&gt;&gt;</a>
     <%
     }
       %></td>
  </tr>
</table>
