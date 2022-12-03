<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
ComparaisonProductionPrise rv=new ComparaisonProductionPrise();
String listeCrt[]={"journal","difference","daty"};
String listeInt[]={"daty"};
String libEntete[]={"journal","daty","production","totalprise","difference"};
PageRecherche pr=new PageRecherche(rv,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ventegazety/comparaisonProdPrise.jsp");
affichage.Champ[] liste=new affichage.Champ[2];
TypeObjet to=new TypeObjet();
to.setNomTable("journal");
liste[0]=new Liste("journal",to,"val","val");
TypeObjet to1=new TypeObjet();
to1.setNomTable("differenciation");
liste[1]=new Liste("difference",to1,"val","val");
pr.getFormu().changerEnChamp(liste);
//String libAffiche[]={"id","nom","daty","journal","somme","type"};
String colSomme[]={"production","totalprise","difference"};

pr.creerObjetPage(libEntete,colSomme);
ComparaisonProductionPrise []listeP=(ComparaisonProductionPrise [])pr.getRs().getResultat();
//pr.preparerDataFormu();
%>
<h1>Comparaison production/prise</h1>
<form action="<%=pr.getLien()%>?but=ventegazety/comparaisonProdPrise.jsp" method="post" name="comparaison" id="comparaison">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
out.println(pr.getTableauRecap().getHtml());%>
<br>
<br/>
<br/>
<table class="monographe" width="100%" cellspacing="3" cellpadding="3" border="0" align="center" id="mydiv">
   <tr>
     <td bgcolor="#66CCFF" align="center"><b>journal</b></td>
     <td bgcolor="#66CCFF" align="center"><b>daty</b></td>
     <td bgcolor="#66CCFF" align="center"><b>production</b></td>
     <td bgcolor="#66CCFF" align="center"><b>totalprise</b></td>
     <td bgcolor="#66CCFF" align="center"><b>difference</b></td>
   </tr>
   <%for(int i=0;i<listeP.length;i++){%>
        <tr>
           <td align="center"><%=listeP[i].getJournal()%></td>
           <td align="center"><%=Utilitaire.datetostring(listeP[i].getDaty())%></td>
           <td align="center"><%=listeP[i].getProduction()%></td>
           <td align="center"><%=listeP[i].getTotalprise()%></td>
   <%if(listeP[i].getDifference()<0){%>
           <td align="center" style="color:red"><%=listeP[i].getDifference()%></td>
   <%}else{%>
           <td align="center"><%=listeP[i].getDifference()%></td>
   <%}%>
         </tr>
    <%}%>
</table>
<%
out.println(pr.getBasPage());
%>
