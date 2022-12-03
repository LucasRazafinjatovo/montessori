<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="finance.*" %>
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
Cheque e=new Cheque();
String etat="chequenonvire";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  etat=request.getParameter("etat");
e.setNomTable(etat);
String listeCrt[]={"numcheque","datysaisie","designation","caisse"};
String listeInt[]={"datysaisie"};
String libEntete[]={"numcheque","datysaisie","designation","caisse","montant","id"};

PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("finance/listeCheque.jsp");
affichage.Champ[] liste=new affichage.Champ[1];
Caisse caisse=new Caisse();
liste[0]=new Liste("caisse",caisse,"desccaisse","idcaisse", true);
pr.getFormu().changerEnChamp(liste);
String[]colSomme={"montant"};
pr.creerObjetPageMultiple(libEntete,colSomme);
%>
<h1>Lister <%=etat%> OR</h1>
<form action="<%=pr.getLien()%>?but=finance/listeCheque.jsp" method="post" name="rapprochement" id="rapprochement">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
<br/>
	etat : 	<select name="etat" class="champ" id="etat" >
            <option value="chequenonvire"  <%if(etat.compareTo("chequenonvire")==0) out.println("selected");%>> cheque non vire </option>
            <option value="chequevirenonvise"  <%if(etat.compareTo("chequevirenonvise")==0) out.println("selected");%>>cheque vire non vise</option>
            <option value="chequevirevise"  <%if(etat.compareTo("chequevirevise")==0) out.println("selected");%>>cheque vire vise</option>
			<option value="chequevirevise"  <%if(etat.compareTo("chequenonrapproche")==0) out.println("selected");%>>cheque non rapproche</option>
		</select>
</form>
<%
pr.setApresLienPage("&etat="+etat);
String lienTableau[]={pr.getLien()+"?but=finance/visualiserMvtCaisse.jsp",pr.getLien()+"?but=finance/detailCheque.jsp"};
String colonneLien[]={"id","numcheque"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);%>
<br>
<%out.println(pr.getTableauRecap().getHtml());%>
<br>

<%

if(etat.compareTo("chequenonvire")==0){
	%>
	<form action="<%=pr.getLien()%>?but=finance/virerChequeMultiple.jsp" method="post" name="listePub" id="listePub">
		<div align="center"><input type="submit" value="virer"></div>
		<%
		out.println(pr.getTableau().getHtmlWithCheckbox());
		%>
	</form>
		<%
}else{
	out.println(pr.getTableau().getHtml());
}
out.println(pr.getBasPage());
%>
