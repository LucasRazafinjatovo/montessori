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
	String idrib = null;
	String debit = null;
	String credit = null;
	String caisse = null;

	try{
		UserEJB u = (UserEJB)session.getAttribute("u");
		String mvttemp = "";
		
		if(request.getParameter("idmvt") != null && request.getParameter("idmvt").compareToIgnoreCase("") != 0){
			mvttemp = request.getParameter("idmvt");
			session.setAttribute("mvttemp", request.getParameter("idmvt"));
			System.out.println("mandalo atoooo ==== " + session.getValue("mvttemp"));
		}else{
			
			mvttemp = (String)session.getValue("mvttemp");
			System.out.println("mandalo atyyy ==== " + mvttemp);
		}
		
		MvtCaisseTous mvt = u.findDetailMvt(mvttemp);
		
		Rib p = new Rib();
		String etat = "RIBNONRAPPRO";
		p.setNomTable(etat);
		String listeCrt[] = {"designation","daty","caisse","numcheque"};
		String listeInt[] = {"daty"};
		String libEntete[]= {"id","daty","designation","numcheque","caisse","debit","credit"};
		PageRecherche pr = new PageRecherche(p,request,listeCrt,listeInt,2,libEntete,7);

		pr.setUtilisateur((user.UserEJB)session.getValue("u"));
		pr.setLien((String)session.getValue("lien"));
		pr.setApres("finance/rapprocherMvtRib.jsp&etat="+etat);
		affichage.Champ[] liste=new affichage.Champ[1];
		Caisse to2 = new Caisse();
		to2.setNomTable("caisse");
		liste[0] = new Liste("caisse",to2,"desccaisse","desccaisse", true);

		pr.getFormu().changerEnChamp(liste);


		String colSomme[]={"debit","credit"};
		pr.creerObjetPageMultiple(libEntete,colSomme);
		
		
%>
</br>
VOTRE CHOIX
<table width="100%"  border="0" class="monographe">
  <tr>
    <td width="27%" class="left">ID mouvement <%=mvttemp%></td>
    <td width="73%"><div align="center"><%=mvt.getDesignation()%></div></td>
  </tr>
  <tr>
    <td class="left">Date de mouvement</td>
    <td><div align="center"><%=mvt.getDatyvaleur()%></div></td>
  </tr>
  <tr>
    <td class="left">Caisse</td>
    <td><div align="center"><%=mvt.getIdcaisse()%></div></td>
  </tr>
  <tr>
    <td class="left">Montant</td>
    <td><div align="center"><% if(mvt.getDebit() > 0) out.println(Utilitaire.formaterAr(mvt.getDebit()) + " (Debit)"); else out.println(Utilitaire.formaterAr(mvt.getCredit()) + " (Credit)");%> Ar </div></td>
  </tr>
</table><br>
<h1>Lister RIB</h1>
<form action="<%=pr.getLien()%>?but=finance/rapprocherMvtRib.jsp" method="post" name="listePub" id="listePub">
<input type="hidden" name="idrib" value="<%=request.getParameter("idrib")%>">
<%out.println(pr.getFormu().getHtmlEnsemble());%>

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
		<input name="acte" type="hidden" id="nature" value="mvtmultiple">
		<input name="idmvt" type="hidden" id="nature" value="<%=mvttemp%>">
		<input name="bute" type="hidden" id="bute" value="finance/listeMvtCaisseSansLc.jsp">
		
		<input name="classe" type="hidden" id="classe" value="finance.RapprochementBancaire">
    </div>
	<%
	out.println(pr.getTableau().getHtmlWithCheckbox());
	out.println(pr.getBasPage());
%>
</form>

<%
	}catch(Exception e){
		e.printStackTrace();
		%>
		<script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
		<%
		return;
	}
%>