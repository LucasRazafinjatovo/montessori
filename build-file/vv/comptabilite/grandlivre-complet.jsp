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
String etat="grand_livre";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0){
	etat=request.getParameter("etat");
}
p.setNomTable(etat);
if (etat.compareTo("grand_livre_lettre") == 0){
	p = new EcritureLettre();
}

String listeCrt[]={"societe","codejournal","numero", "compte","comptetiers", "numpiece",  "libelle", "daty", "echeance", "exercice"};
String listeInt[]={"numero", "daty", "echeance"};

PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));

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
pr.setApres("comptabilite/grandlivre-complet.jsp");

String libEntete[]= null;
String colSomme[]= null ;
if (etat.compareTo("grand_livre") == 0){
	colSomme = new String[3];
	colSomme[0] = "MONTANTDEBIT"; colSomme[1] = "MONTANTCREDIT"; colSomme[2] = "SOLDE";
	libEntete = new String[11];
	libEntete[0] = "id"; libEntete[1] = "codejournal"; libEntete[2] = "compte";
    libEntete[3] = "numero"; libEntete[4] = "daty"; libEntete[5] = "comptetiers";
    libEntete[6] = "numpiece"; libEntete[7] = "libelle"; libEntete[8] = "echeance";
    libEntete[9] = "montantdebit"; libEntete[10] = "montantcredit";
}
else if (etat.compareTo("grand_livre_lettre") == 0){
	colSomme = new String[2];
	colSomme[0] = "MONTANTDEBIT"; colSomme[1] = "MONTANTCREDIT";
	libEntete = new String[12];
	libEntete[0] = "id"; libEntete[1] = "codejournal"; libEntete[2] = "compte";
    libEntete[3] = "numero"; libEntete[4] = "daty"; libEntete[5] = "comptetiers";
    libEntete[6] = "numpiece"; libEntete[7] = "libelle"; libEntete[8] = "echeance";
    libEntete[9] = "montantdebit"; libEntete[10] = "montantcredit"; libEntete[11] = "lettres";
}
else{
	colSomme = new String[2];
	colSomme[0] = "MONTANTDEBIT"; colSomme[1] = "MONTANTCREDIT";
	libEntete = new String[11];
	libEntete[0] = "id"; libEntete[1] = "codejournal"; libEntete[2] = "compte";
    libEntete[3] = "numero"; libEntete[4] = "daty"; libEntete[5] = "comptetiers";
    libEntete[6] = "numpiece"; libEntete[7] = "libelle"; libEntete[8] = "echeance";
    libEntete[9] = "montantdebit"; libEntete[10] = "montantcredit"; 
}

pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Grand livre</h1>
<form action="<%=pr.getLien()%>?but=comptabilite/grandlivre-complet.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
<br/>
	etat : 	<select name="etat" class="champ" id="etat" >
            <option value="grand_livre"  <%if(etat.compareTo("grand_livre")==0) out.println("selected");%>>Grand livre</option>
			<option value="grand_livre_alettre"  <%if(etat.compareTo("grand_livre_alettre")==0) out.println("selected");%>>A lettrer</option>
            <option value="grand_livre_lettre"  <%if(etat.compareTo("grand_livre_lettre")==0) out.println("selected");%>>Lettre</option>
		</select>
</form>
<%
pr.setApresLienPage("&etat="+etat);
out.println(pr.getTableauRecap().getHtml());
%>
<br>
<form method="post" name="e" action="<%=pr.getLien()%>?but=comptabilite/apresCompta.jsp">
	<%
		if(etat.compareTo("grand_livre_alettre")==0){
			out.println(pr.getTableau().getHtmlWithCheckbox());
	%>

		<div align="center">
            <input type="submit" value="Valider">
            <input type="hidden" name="acte" value="lettrer-ecriture">
            <input type="hidden" name="bute" value="comptabilite/grandlivre-complet.jsp">
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
