<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>

<%
    try
{
PubClientLibelle p=new PubClientLibelle();

String etat = "pub_client_libelle";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0){
  etat=request.getParameter("etat");
}
p.setNomTable(etat);
String listeCrt[]={"date_debut_diff","date_fin_diff","idtype","idplage","client"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,null,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("pub/pubclient-liste.jsp");
pr.getFormu().getChamp("date_debut_diff").setLibelleAffiche("date debut diffusion");
pr.getFormu().getChamp("date_fin_diff").setLibelleAffiche("date fin diffusion");
pr.getFormu().getChamp("idtype").setLibelleAffiche("Type pub");
pr.getFormu().getChamp("idplage").setLibelleAffiche("Numero plage");
String libEntete[]={"id","client","nom_compagne","nom_pub","ref","idtype","idplage","date_debut_diff","date_fin_diff","duree"};
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
PubClientLibelle[] pf=(PubClientLibelle[])pr.getRs().getResultat();
%>
<h1>Liste des tarifs</h1>
<form action="<%=pr.getLien()%>?but=pub/pubclient-liste.jsp" method="post" name="listeParution" id="listeParution">
    <%
out.println(pr.getFormu().getHtmlEnsemble());%>
    etat : <select name="etat" class="champ" id="etat" >
        <option value="pub_client_libelle"  <%if(etat.compareTo("pub_client_libelle")==0) out.println("selected");%>>Tous</option>
        <option value="pub_client_libnonfact"  <%if(etat.compareTo("pub_client_libnonfact")==0) out.println("selected");%>>non facturée</option>
        <option value="pub_client_libfact"  <%if(etat.compareTo("pub_client_libfact")==0) out.println("selected");%>> factur&eacute; et vis&eacute;</option>

    </select>
</form>
<%
  String [] libelleAffiche={"Id","Client","Nom compagne","Nom pub","reference","type pub","numero plage","date debut diffusion","date fin diffusion","duree"};
  String lienTableau[]={pr.getLien()+"?but=pub/pubclient-fiche.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLibelleAffiche(libelleAffiche);
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);

out.println(pr.getTableauRecap().getHtml());%>
<br>

<form method="post" name="e" action="<%=pr.getLien()%>?but=facture/factureInit.jsp">
    <div id="divchck">
        <table class="monographe" width="100%" cellspacing="3" cellpadding="3" border="0" align="center" id="mydiv">
            <tr>
                <td bgcolor="#66CCFF" align="center"><b>id</b></td>
                <td bgcolor="#66CCFF" align="center"><b>Client</b></td>
                <td bgcolor="#66CCFF" align="center"><b>Nom campagne</b></td>
                <td bgcolor="#66CCFF" align="center"><b>REF</b></td>
                <td bgcolor="#66CCFF" align="center"><b>Type</b></td>
                <td bgcolor="#66CCFF" align="center"><b>Plage</b></td>
                <td bgcolor="#66CCFF" align="center"><b>Début</b></td>
                <td bgcolor="#66CCFF" align="center"><b>Fin</b></td>
                <td bgcolor="#66CCFF" align="center"><b>Durée</b></td>
                <td bgcolor="#66CCFF" align="center"><input type="checkbox" id="cocheTout"></td>
            </tr>
            <tr>
                <td align="center"><a href="<%=pr.getLien()%>?but=pub/pubclient-fiche.jsp&id=<%=pf[i].getId()%>"><%=pf[i].getId()%></a></td>
                <td align="center"><%=pf[i].getClient()%></td>
                <td align="center"><%=pf[i].getNom_compagne()%></td>
                <td align="center"><%=pf[i].getRef()%></td>
                <td align="center"><%=pf[i].getIdtype()%></td>
                <td align="center"><%=pf[i].getIdplage()%></td>
                <td align="center"><%=Utilitaire.datetostring(pf[i].getDate_debut_diff())%></td>
                <td align="center"><%=Utilitaire.datetostring(pf[i].getDate_fin_diff())%></td>
                <td align="center"><%=pf[i].getDuree()%></td>
                <%if(etat.compareTo("pub_client_libnonfact")==0){%>
                <td><input type="checkbox" id="checkbox<%=i%>" onclick="getChoixGazety(this)" name="id" value="<%=pf[i].getId()%>"/>
                </td>
                <%}else{%>
                <td></td>

                <% }
        }%>
            </tr>
    </div>
    <input name="nombrechoix" id="nombrechoix" class="submit" type="hidden" value="0">
    <input name="nomjournal" id="nomjournal" class="submit" type="hidden" value="0"></div>
    <%if(etat.compareTo("pub_client_libnonfact")==0){%>
    <div align="center">
        <input type="submit" value="Valider">
        <input type="hidden" name="acte" value="pub">
        <input type="hidden" name="bute" value="pub/pubclient-liste.jsp">
    </div>
    <%}%>
</form>
<%//out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
}
catch(Exception e)
{
  e.printStackTrace();
}
%>
