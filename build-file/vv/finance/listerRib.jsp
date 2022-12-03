<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="finance.*" %>
<%

Rib e=new Rib();
String etat="RibTous";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  etat=request.getParameter("etat");
e.setNomTable(etat);
String listeCrt[]={"numcheque","daty","numcheque","caisse"};
String listeInt[]={"daty"};
String libEntete[]={"daty","designation","numcheque","caisse","debit","credit"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("finance/listerRib.jsp");
affichage.Champ[] liste=new affichage.Champ[1];
Caisse caisse=new Caisse();
liste[0]=new Liste("caisse",caisse,"desccaisse","idcaisse");
pr.getFormu().changerEnChamp(liste);
String[]colSomme = {"debit","credit"};
pr.creerObjetPage(libEntete,colSomme);
pr.getFormu().getChamp("daty1").setLibelle("date1");
pr.getFormu().getChamp("daty2").setLibelle("date2");
%>
<h1>Lister RIB</h1>
<form action="<%=pr.getLien()%>?but=finance/listerRib.jsp" method="post" name="rapprochement" id="rapprochement">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
<br/>
etat : <select name="etat" class="champ" id="etat" >
            <option value="RibTous"  <%if(etat.compareTo("RibTous")==0) out.println("selected");%>>Tous</option>
            <option value="rapprochementbancaire"  <%if(etat.compareTo("rapprochementbancaire")==0) out.println("selected");%>> rapproch&eacute; </option>
            <option value="chequenonrapproche"  <%if(etat.compareTo("chequenonrapproche")==0) out.println("selected");%>>non rapproch&eacute;</option>
</select>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=finance/ficheRib.jsp"};
String colonneLien[]={"numcheque"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);%>
<br>
<%out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>
