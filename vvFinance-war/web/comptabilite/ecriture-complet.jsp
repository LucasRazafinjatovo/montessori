<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="comptabilite.*" %>
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
try
{
Ecriture p=new Ecriture();
String etat="ecriture_libelle3";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0){
	etat=request.getParameter("etat");
}
p.setNomTable(etat);
String listeCrt[]={"societe","codejournal","numero", "compte","comptetiers", "numpiece",  "libelle", "daty", "echeance", "exercice"};
String listeInt[]={"numero", "daty", "echeance"};
String libEntete[]={"numero","societe","codejournal","numpiece","libelle","montantdebit","montantcredit"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("comptabilite/ecriture-avise.jsp");
pr.setNpp(60);

affichage.Champ[] liste=new affichage.Champ[2];
TypeObjet to=new TypeObjet();
to.setNomTable("journalcompta");
liste[0]=new Liste("codejournal",to, "desce", "desce");
Societe to1=new Societe();
liste[1]=new Liste("societe",to1,"nom","nom");
pr.getFormu().changerEnChamp(liste);

pr.getFormu().getChamp("exercice").setPageAppel("comptabilite/choixExercice.jsp");
pr.getFormu().getChamp("compte").setPageAppel("comptabilite/choixCompte.jsp");
pr.getFormu().getChamp("comptetiers").setPageAppel("comptabilite/choixCompteTiers.jsp");
pr.getFormu().getChamp("comptetiers").setLibelle("Compte tiers");
pr.getFormu().getChamp("numpiece").setLibelle("N° piece");
pr.getFormu().getChamp("codejournal").setLibelle("Journal");
pr.getFormu().getChamp("daty1").setLibelle("Date (min)");
pr.getFormu().getChamp("daty2").setLibelle("Date (max)");
pr.getFormu().getChamp("echeance1").setLibelle("Echeance (min)");
pr.getFormu().getChamp("echeance2").setLibelle("Echeance (max)");
pr.getFormu().getChamp("numero1").setLibelle("Numero (min)");
pr.getFormu().getChamp("numero2").setLibelle("Numero (max)");

String colSomme[]={"montantdebit", "montantcredit"};
pr.creerObjetPage(libEntete,colSomme);
Ecriture[] pf=(Ecriture[])pr.getRs().getResultat();
%>
<h1>Liste des écritures</h1>
<form action="<%=pr.getLien()%>?but=comptabilite/ecriture-complet.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
<br/>
	etat : 	<select name="etat" class="champ" id="etat" >
            <option value="ecriture_libelle3"  <%if(etat.compareTo("ecriture_libelle3")==0) out.println("selected");%>>Liste des ecritures</option>
			<option value="ecriture_avisee"  <%if(etat.compareTo("ecriture_avisee")==0) out.println("selected");%>>A viser</option>
		</select>
</form>
<%
pr.setApresLienPage("&etat="+etat);

String lienTableau[]={pr.getLien()+"?but=comptabilite/ecriture-fiche.jsp"};
String colonneLien[]={"numero"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
String libEnteteAffiche[] = {"N° ecriture", "Soci&eacute;t&eacute;", "Code journal", "N° piece", "Libell&eacute;", "Montant debit", "Montant credit"};
pr.getTableau().setLibelleAffiche(libEnteteAffiche);

out.println(pr.getTableauRecap().getHtml());
%>
<br>
<form method="post" name="e" action="<%=pr.getLien()%>?but=comptabilite/apresCompta.jsp">
	<%
		if(etat.compareTo("ecriture_avisee")==0){
			out.println(pr.getTableau().getHtmlWithCheckbox());
	%>
	<div align="center">
            <input type="submit" value="Valider">
            <input type="hidden" name="acte" value="visamultiple-ecriture">
            <input type="hidden" name="bute" value="comptabilite/ecriture-complet.jsp">
     </div>
</form>
<%
		}else{
			out.println(pr.getTableau().getHtml());
		}
out.println(pr.getBasPage());
}
catch(Exception e)
{
  e.printStackTrace();
}
%>
