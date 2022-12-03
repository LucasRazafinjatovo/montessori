<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="prevision.*" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%

PrevisionEtat previsionEtat = new PrevisionEtat();

String listeCrt[]={"daty"};
String listeInt[]={"daty"};
String libEntete[]={"daty"};

PageRecherche pr=new PageRecherche(previsionEtat,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("prevision/listePrevisionTranspose.jsp");
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
String daty1=request.getParameter("daty1"); if(daty1==null || daty1.compareToIgnoreCase("")==0) daty1="01/"+Utilitaire.getMoisEnCours()+"/"+Utilitaire.getAneeEnCours();
String daty2=request.getParameter("daty2"); if(daty2==null || daty2.compareToIgnoreCase("")==0) daty2="15/"+Utilitaire.getMoisEnCours()+"/"+Utilitaire.getAneeEnCours();

// Listes des prévisions
PrevisionEtat[] listePrevision =(PrevisionEtat[])CGenUtil.rechercher(previsionEtat,null,null," and '"+daty1+"'<=daty and daty<='"+daty2+"'");
double solde = 0.d;
double soldeAffiche = 0.d;
for(int k=0;k<listePrevision.length;k++){
  solde += listePrevision[k].getSolde();
  listePrevision[k].setSolde(solde);
}
%>
<h1>Etat pr&eacute;vision </h1>
<form action="<%=pr.getLien()%>?but=prevision/listePrevisionTranspose.jsp" method="post" name="listeprevision" id="listeprevision">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<!--LISTE ETAT PREVISIONS -->
<p align="center"><strong><u>LISTE DES PREVISIONS</u></strong></p>
<table border="1" cellpadding="2" cellspacing="0" align="center" class="monographe" width="100%">
  <tr class="head" height="30">
     <td align="center" valign="center"><div align="center">Date</div></td>
     <td align="left" valign="center"><div align="center">Designation lc</div></td>
     <td align="right" valign="center"><div align="center">Débit prévision</div></td>
     <td align="right" valign="center"><div align="center">Crébit prévision</div></td>
     <td align="left" valign="center"><div align="center">Solde</div></td>
     <td align="left" valign="center"><div align="center">Id LC</div></td>
  </tr>
<%for(int k=0;k<listePrevision.length;k++){
   %>
  <tr>
    <td align="center" style="background-color:WHITE"><%=Utilitaire.datetostring(listePrevision[k].getDaty())%></td>
    <td align="left" style="background-color:WHITE"><%=listePrevision[k].getDesignationlc()%></td>
    <%
    if("rec".equalsIgnoreCase(listePrevision[k].getTyp())){
    %>
      <td align="right" style="background-color:WHITE"><%=listePrevision[k].getDebit()%></td>
      <td align="right" style="background-color:WHITE"><a href="<%=pr.getLien()%>?but=prevision/fichePrevisionRecette.jsp&idligne=<%=listePrevision[k].getIdligne()%>&daty=<%=Utilitaire.datetostring(listePrevision[k].getDaty())%>&montant=<%=listePrevision[k].getCredit()%>" title="<%=listePrevision[k].getIdligne()%>" class="prevision"><%=Utilitaire.formaterAr(listePrevision[k].getCredit())%></a></td>
    <%
      }else{
    %>
    <td align="right" style="background-color:WHITE"><a href="<%=pr.getLien()%>?but=prevision/fichePrevisionDepense.jsp&idligne=<%=listePrevision[k].getIdligne()%>&daty=<%=Utilitaire.datetostring(listePrevision[k].getDaty())%>&montant=<%=listePrevision[k].getDebit()%>" title="<%=listePrevision[k].getIdligne()%>" class="prevision"><%=Utilitaire.formaterAr(listePrevision[k].getDebit())%></a></td>
    <td align="right" style="background-color:WHITE"><%=listePrevision[k].getCredit()%></td>
    <%}%>

    <% if(listePrevision[k].getSolde() < 0){
    %>
    <td align="right" style="background-color:WHITE">(<%=-(listePrevision[k].getSolde())%>)</td>
    <%}else{%>
    <td align="right" style="background-color:WHITE"><%=listePrevision[k].getSolde()%></td>
     <%}%>
    <td align="right" style="background-color:WHITE"><%=listePrevision[k].getIdligne()%></td>
  </tr>
  <%}%>
</table>
