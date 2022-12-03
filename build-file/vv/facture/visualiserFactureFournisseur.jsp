<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="facturefournisseur.FactureFournisseur" %>
<%@ page import="facturefournisseur.Detail" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
  String apres="facture/apresvisualiserFactureFournisseur.jsp";
  String lien= null;
  facture.Client clt[] = null;
  UserEJB u = null;
  TypeObjet tyo[] = null;
  TypeObjet dev[] = null;
  TypeObjet mp[] =null;
  TypeObjet source[] =null;
  TypeObjet ag[] =null;
  Caisse caiss[] = null;
  String idFact = null;
  facture.Tva tva = null;
  String nature=null;
  String idDed=null;
  Detail detail[]= null;
  FactureFournisseur bc[] = null;
     %>
<%
  idFact=request.getParameter("idBC");
     if(idFact==null||idFact.compareToIgnoreCase("")==0)idFact=request.getParameter("idFactureFournisseur");
     nature=request.getParameter("nature");if ((nature==null)||nature.compareTo("")==0) nature="factureF";
     idDed=request.getParameter("idDed");
     if(idFact == null) idFact = "";
     try{
       u=(user.UserEJB)session.getValue("u");
       lien=(String)session.getValue("lien");
       out.println("lien = "+lien);
//dev = u.findTva("%", "%","","");
       clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
       tva = u.loadTva(Utilitaire.dateDuJour());
       FactureFournisseur crt=new FactureFournisseur();
       crt.setIdFactureFournisseur(idFact);
       crt.setNomTable("FACTUREFOURNISSEURLETTRE");
       bc=(FactureFournisseur[])CGenUtil.rechercher(crt, null,null,"");
       //bc=u.findFactureFournisseur("FACTUREFOURNISSEURLETTRE", idFact, "", "", "%","%","daty","asc", "");
       //bc = u.findEntFact(nature,idFact, "%","%","%","%","%","%","","","%");
       if(bc.length==0)
       {
         out.print("Le bon de comande n extiste pas");
         return;
       }//(String nomTable, String id, String idMere, String designation, String qte1, String qte2, String puHT1, String puHT2, String rem)
       //detail=u.findDetail(nature,"%",bc[0].getTuppleID(),"%","","","","","%");

     }catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  }
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>Visualiser <%=nature%> num <%=bc[0].getIdFactureFournisseur() %></h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
<tr>
            <td width="35%" class="left">Num Facture Fournisseur : </td>
            <td width="65%" align="center"><%=bc[0].getIdFactureFournisseur() %>    </td>
          </tr>

          <tr>
            <td class="left">Date : <span class="remarque">*</span></td>
            <td align="center"> <%=bc[0].getDaty() %>   </td>
          </tr>
          <tr>
            <td class="left">Date emission : <span class="remarque">*</span></td>
            <td align="center"><%=bc[0].getDateEmission() %></td>
          </tr>
           <tr>
            <td class="left">Date d'&eacute;cheance:</td>
            <td align="center"><%=bc[0].getDatyecheance() %></td>
          </tr>
          <tr>
            <td class="left">Designation : <span class="remarque">*</span></td>
            <td align="center"> <%=bc[0].getDesignation() %> </td>
          </tr>
          <tr>
            <td class="left">Fournisseur: <span class="remarque">*</span></td>
            <td align="center">            <%=bc[0].getIdFournisseur() %> </td>
          </tr>
          <tr>
            <td class="left">Montant TTC : </td>
            <td align="center"><%=Utilitaire.formaterAr(bc[0].getMontantTTC()) %></td>
          </tr>
          <tr>
            <td class="left">Montant tva : <span class="remarque">*</span></td>
            <td align="center">
             <%=Utilitaire.formaterAr(bc[0].calculMontantTva()) %></td>
          </tr>
          <tr>
            <td class="left">Devise : <span class="remarque">*</span></td>
            <td align="center"><%=bc[0].getIdDevise() %></td>
          </tr>
          <tr>
            <td class="left">Remarque : </td>
            <td align="center"><%=bc[0].getRemarque() %></td>
          </tr>




        </table></td>
    </tr>
        <tr>
    <td height="30" align="center">



    <table border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center"><input name="typeObjet" type="hidden" id="nature" value="<%=nature%>">
   <input name="numObjet" type="hidden" id="numObjet" value="<%=bc[0].getIdFactureFournisseur() %>">
<input name="montantObjet" type="hidden" id="montantObjet" value="<%=bc[0].getMontantTTC() %>">
   <input type="hidden" name="acte" value="viser" />
             &nbsp;
    <input type="submit" name="Submit" value="Visualiser Jointure LC" class="submit"
 onClick="acte.value='vOP'">
 &nbsp;
 <input type="submit" name="Submit" value="Modifier" class="submit"
 onClick="acte.value='modifier'">
&nbsp;
<%//if(u.getUser().getLoginuser().compareToIgnoreCase("tahina")==0 || u.getUser().getLoginuser().compareToIgnoreCase("mamyvisa")==0 || u.getUser().getLoginuser().compareToIgnoreCase("lalanirina")==0 || u.getUser().getLoginuser().compareToIgnoreCase("assist")==0){
%>
<input type="button" name="Submit" value="Viser" class="submit"
 onClick="parent.location='<%=lien%>?but=facturefournisseur/viserFacture.jsp&numObjet=<%=idFact%>'">
<%//}
%>
       <input type="submit" name="Submit" value="Saisir det." class="submit"
 onClick="acte.value='detail'"><%
if((bc[0].estAnnulable()==true)&&(u.getUser().getIdrole().compareTo("dg")==0)){%>
                    <input type="submit" name="Submit" value="annuler" class="submit" onClick="acte.value='annuler'">&nbsp;<%}%>
			</td>

          </td>

  </tr>
</table>

<h2>Details de la Facture Fournisseur </h2>
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr class="head">

          <td width="66" align="center" valign="top">num</td>
                   <td width="153" align="right" valign="top"><div align="center">Designation</div></td>
          <td width="153" align="right" valign="top"><div align="center">Quantité</div></td>
          <td width="153" align="right" valign="top"><div align="center"><strong>PU </strong></div></td>
  <td width="102" align="center" valign="top">Remarque</td>
<td width="102" align="center" valign="top"></td>
        </tr>

                    </div>
          </table>



    </td>
        </tr>
</table>

</form>


<div align="center">

  <span class="remarque">(*) Champs obligatoires</span></div>