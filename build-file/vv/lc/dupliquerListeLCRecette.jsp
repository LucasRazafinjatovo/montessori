<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="lc.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<script language="JavaScript">
  $(document).ready(function() {
      $('#cocheTout').click(function() {

          var cases = $("#divchck").find(':checkbox');
          if(this.checked){
              cases.attr('checked', true);
              $('#cocheText').html('Tout decocher');
          }else{
              cases.attr('checked', false);
              $('#cocheText').html('Tout cocher');
          }

      });

});
</script>
<%
LigneCreditComplet e=new LigneCreditComplet();
e.setNomTable("LIGNECREDITRECETTECOMPLET");
String listeCrt[]={"designation","idLigne","mois","annee", "abbrevdir", "numCompte", "entite", "parution", "typeLC"};
String listeInt[]={"annee"};
String libEntete[]={"idLigne","designation","creditInitial","entite","typeLC","abbrevdir", "mois"};

PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("lc/dupliquerListeLCRecette.jsp");
affichage.Champ[] liste=new affichage.Champ[3];

//direction, entite

TypeObjet to=new TypeObjet();
to.setNomTable("typeentreeliste");
liste[0]=new Liste("typeLc",to, "val", "val");

Direction dir = new Direction();
liste[1]=new Liste("abbrevdir",dir, "abbrevDir", "idDir");

TypeObjet to2=new TypeObjet();
to2.setNomTable("beneficiaire");
liste[2]=new Liste("entite",to2, "val", "val");

pr.getFormu().changerEnChamp(liste);
pr.getFormu().getChamp("abbrevdir").setLibelle("Direction");
pr.getFormu().getChamp("numCompte").setLibelle("Numero compte");
pr.getFormu().getChamp("typeLC").setLibelle("Type LC");

String[]colSomme={"creditInitial"};
pr.creerObjetPageMultiple(libEntete,colSomme);
%>
<h1>Lister Ligne crédit recette</h1>
<form action="<%=pr.getLien()%>?but=lc/dupliquerListeLCRecette.jsp" method="post" name="rapprochement" id="rapprochement">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=lc/visualiserDetailLCRecette.jsp"};
String colonneLien[]={"idLigne"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);

String[] attLien={"numObjet"};
String valeurLien[]={"idLigne"};
pr.getTableau().setValeurLien(valeurLien);
pr.getTableau().setAttLien(attLien);
%>
<br>
<%out.println(pr.getTableauRecap().getHtml());%>
<br>


<form action="<%=pr.getLien()%>?but=lc/dupliqueMultipleLC.jsp" method="post" name="listePub" id="listePub">
	<div align="center"><input type="submit" value="dupliquer"></div>
	<%
		String libEnteteAffiche[] = {"ID Ligne", "D&eacute;signation", "Crédit", "Entit&eacute;", "Type LC", "Direction", "Mois"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
		out.println(pr.getTableau().getHtmlWithCheckbox());
	%>
	<input type="hidden" name="classeLC" value="LIGNECREDITRECETTECOMPLET">
	<input type="hidden" name="apresDupl" value="dupliquerListeLCRecette">
</form>
<%
out.println(pr.getBasPage());
%>
