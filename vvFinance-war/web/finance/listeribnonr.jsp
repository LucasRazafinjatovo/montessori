<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.Ded" %>
<%@ page import="ded.OrdonnerPayement" %>
<%@ page import="affichage.*" %>
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
try{
Rib p = new Rib();
String etat = "RibTous";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  etat=request.getParameter("etat");
p.setNomTable(etat);
String listeCrt[]={"designation","debit","credit","daty","caisse","numcheque"};
String listeInt[]={"daty","debit","credit"};
String libEntete[]={"id","daty","designation","numcheque","caisse","debit","credit"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2,libEntete,7);

pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("finance/listeribnonr.jsp&etat="+etat);
affichage.Champ[] liste=new affichage.Champ[1];
Caisse to2 = new Caisse();
to2.setNomTable("caisse");
liste[0]=new Liste("caisse",to2,"desccaisse","desccaisse");

pr.getFormu().changerEnChamp(liste);


String colSomme[]={"debit","credit"};
pr.creerObjetPageMultiple(libEntete,colSomme);
//pr.preparerDataFormu();
%>
<h1>Lister RIB</h1>
	<form action="<%=pr.getLien()%>?but=finance/listeribnonr.jsp" method="post" name="listePub" id="listePub">
	<%
	out.println(pr.getFormu().getHtmlEnsemble());%>
	<br/>
	etat : 	<select name="etat" class="champ" id="etat" >
				<option value="RibTous"  <%if(etat.compareTo("RibTous")==0) out.println("selected");%>>Tous</option>
				<option value="rapprochementbancaire"  <%if(etat.compareTo("rapprochementbancaire")==0) out.println("selected");%>> rapproch&eacute; </option>
				<option value="RIBNONRAPPRO"  <%if(etat.compareTo("RIBNONRAPPRO")==0) out.println("selected");%>>non rapproch&eacute;</option>
			</select>
	</form>
<%
String lienTableau[]={pr.getLien()+"?but=finance/ficheRibnonr.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="<%=pr.getLien()%>?but=finance/apresRib.jsp" method="post" name="listePub" id="listePub">
 <div align="center">
	    <input type="submit" value="rapprocher">
		<input name="acte" type="hidden" id="nature" value="ribmultiple">
		<input name="bute" type="hidden" id="bute" value="finance/listeribnonr.jsp">
		<input name="classe" type="hidden" id="classe" value="finance.RapprochementBancaire">
     </div>
<%
out.println(pr.getTableau().getHtmlWithCheckbox());
out.println(pr.getBasPage());
%>
</form>
<%
}
catch(Exception e){
  e.printStackTrace();
  %>
   <script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
  <%
  return;
}
%>


<script language="javascript">
  var cal1 = new calendar1(document.forms['listeRecette'].elements['dateDebut']);
  cal1.year_scroll = false;
  cal1.time_comp = false;
  var cal2 = new calendar1(document.forms['listeRecette'].elements['dateFin']);
  cal2.year_scroll = false;
  cal2.time_comp = false;

</script>