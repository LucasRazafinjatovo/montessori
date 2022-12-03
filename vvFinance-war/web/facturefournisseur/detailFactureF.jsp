<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facturefournisseur.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%!
	String apres="facture/apresInit.jsp";
	double totalPaiment=0;
	double totalReste=0;
	/*
	facture.Client clt = null;
	facture.FactMere fm = null;
        
	facture.FactureFille ff[] = null;
	String idClient = null;
       
        Change dollar = null;
        TypeObjet factEn = null;
        
        */
		 finance.Sortie sort[]= null;
		historique.MapUtilisateur ut=null;
		String lien= null;
		 UserEJB u = null;
		facturefournisseur.FactureFournisseur ff=null;
		facturefournisseur.Fournisseur frnss=null;
		TypeObjet devEn = null;
		String idFactF = null;
%>
<%
idFactF =request.getParameter("idFactureFournisseur");
out.println("id facture="+idFactF);
%>
<%
try{
  u=(user.UserEJB)session.getValue("u");
  lien=(String)session.getValue("lien");
  ut=u.getUser();

 	ff = u.findFactureF(idFactF, "", "", "%","%","%", "IDFACTUREFOURNISSEUR", "DESC","")[0];
   	frnss = u.findFournisseurF(ff.getidFournisseur(),"%","%","%","%","%","%","")[0];
	 sort= u.findSortieAgence("%","","","%","%","", "%", "%","", "eta2","%","%","idfacture","ASC", "%","%", idFactF);
  //for (int i=0;i<frnss.length;i++){
  //System.out.println(frnss.getnomFournisseur());
//}
  //out.println("idF= "+ff.getidFournisseur());
  devEn = u.findTypeObjet("devise",ff.getidDevise(),"%")[0];
  
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<title>Aper&ccedil;u facture</title>
<h2>Details Facture n&deg;</h2>
<p>&nbsp;</p>
<h2>&nbsp;</h2>



<h2><br>
</h2>
<table width="75%" border="1" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="18%" bgcolor="#0099FF"><font color="#FFFFFF">DESIGNATION</font></td>
    <td width="1%"><strong>:</strong></td>
    <td width="81%"><div align="left"><%=ff.getdesignation()%></div></td>
  </tr>
<tr> 
    <td bgcolor="#0099FF"><font color="#FFFFFF">Enregistrée le:</font></td>
    <td><strong>:</strong></td>
    <td><div align="left"><%=Utilitaire.formatterDaty(ff.getdaty())%></div></td>
  </tr>
   <tr> 
    <td bgcolor="#0099FF"><font color="#FFFFFF">Fournisseur</font></td>
    <td>:</td>
    <td><div align="left"><%=frnss.getnomFournisseur()%></div></td>
  </tr>
   <tr> 
    <td bgcolor="#0099FF"><font color="#FFFFFF">Devise</font></td>
    <td>:</td>
    <td><div align="left"><%=devEn.getVal()%></div></td>
  </tr>
   <tr> 
    <td bgcolor="#0099FF"><font color="#FFFFFF">Remarques</font></td>
    <td>:</td>
    <td><div align="left"><%=ff.getremarque()%></div></td>
  </tr>
  <tr> 
    <td bgcolor="#0099FF"><font color="#FFFFFF">Projet</font></td>
    <td>:</td>
    <td><div align="left"><%=ff.getidProjet()%></div></td>
  </tr>
  <tr> 
    <td bgcolor="#0099FF"><font color="#FFFFFF">TVA</font></td>
    <td>:</td>
    <td><div align="left"><%=ff.getidTVA()%></div></td>
  </tr>
</table>
  
<p align="center"><strong><u>LISTE DES PAIEMENTS EFFECTUES</u></strong></p>
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="107" valign="top"><div align="center">Date</div></td>
          <td width="156" height="19" valign="top"><div align="center"><strong>D&eacute;signation</strong></div></td>
          <td width="145" valign="top"><div align="center"><strong>Montant </strong></div></td>
          <td width="145" valign="top"><div align="center"><strong>Sortie</strong></div></td>
     
        </tr>
        <%
		 totalPaiment=0;
  for(int i=0;i<sort.length;i++){
  out.println(sort[i].getIdSortie()+" - "+sort[i].getMontant());
  totalPaiment=totalPaiment+((double)sort[i].getMontant());
  %>
        <tr >
          <td align="left" valign="top"><div align="center"><%=Utilitaire.formatterDaty(sort[i].getDaty())%></div></td>
          <td height="19" align="right" valign="top"><%=sort[i].getDesignation()%></td>
          <td align="left" valign="top"><div align="right"><%=Utilitaire.formaterAr((double)sort[i].getMontant())%><%=" "+sort[i].getIdDevise()%></div></td>
                   <td align="center"><a href="<%=lien%>?but=finance/detailSortie.jsp&idSortie=<%=sort[i].getIdSortie()%>"><%=sort[i].getIdSortie()%></a>          </td>
            
        </tr>
        <%
  }
  
  %>
      </table>

Montant payé:<%=Utilitaire.formaterAr(totalPaiment)%><BR>
Montant restant:<%totalReste=ff.getmontantTTC()-totalPaiment;
out.print(Utilitaire.formaterAr(totalReste));

  String apres="facturefournisseur/apresEntreeFacture.jsp";
%>
<BR>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="depense" id="depense" target="_parent">
<input type="hidden" name="acte" value="CLOTURER">
<input type="hidden" name="idf" value="<%=ff.getidFactureFournisseur()%>">
<input type="hidden" name="designation" value="<%=ff.getdesignation()%>">
<input type="hidden" name="daty" value="<%=ff.getdaty()%>">
<input type="hidden" name="fournisseur" value="<%=ff.getidFournisseur()%>">
<input type="hidden" name="montantHT" value="<%=ff.getmontantTHT()%>">
<input type="hidden" name="tva" value="<%=ff.getidTVA()%>">
<input type="hidden" name="montantTTC" value="<%=ff.getmontantTTC()%>">
<input type="hidden" name="remarque" value="<%=ff.getremarque()%>">
<input type="hidden" name="projet" value="<%=ff.getidProjet()%>">
<input type="hidden" name="dateemission" value="<%=ff.getdateEmission()%>">
<input type="hidden" name="idDevise" value="<%=ff.getidDevise()%>">



<input type="button" name="ep" value="Effectuer un paiement" class="submit" onclick="paiement(<%="'"+idFactF+"'"%>)">
<input type="submit" name="cpf" value="Cloturer le paiement de la facture" class="submit" >
</form>
<script language="javascript">
function paiement(idfacture){

document.location.replace("<%=lien%>?but=finance/sortie.jsp&fact=p&idf="+idfacture); 

}

</script>