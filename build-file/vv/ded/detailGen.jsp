<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="facturefournisseur.Detail" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="ded/apresDetailGen.jsp";
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

				String typeObjet = null;
				String numObjet = null;
Detail detail[]= null;
String tableDet =null;
     %>
<%
numObjet=request.getParameter("numObjet");
nature=request.getParameter("nature");
tableDet=request.getParameter("tableDet");
if ((nature==null)||nature.compareTo("")==0) nature="factureF";

try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
out.println("lien = "+lien);
System.out.println("lien = "+lien);
dev = u.findTypeObjet("Devise","%","%");
clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
tva = u.loadTva(Utilitaire.dateDuJour());
/*tyo = u.findTypeObjet("TypeEntree","%","%");
clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
mp = u.findTypeObjet("ModePaiement","%","%");
ag = u.findTypeObjet("Agence","%","%");
dev = u.findTypeObjet("Devise","%","%");
source = u.findTypeObjet("Beneficiaire","%","%");
caiss = u.findCaisse("%","%","%","%");*/
   detail=u.findDetail(nature,"%",numObjet,"%","","","","","%");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>Detail  <%=nature%> </h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
<tr>
            <td class="left">Mere: <span class="remarque">*</span></td>
            <td align="center"> <input name="numObjet" type="text" class="champ"  id="numObjet" value="<%=numObjet%>">
              &nbsp;
			  <input name="choix3" type="button" onClick="pagePopUp('lc/liste_Gen_popup.jsp?typeObjet=<%=typeObjet%>champReturn=idMere')" value="..." class="submit">
			  <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
         <tr>
            <td class="left">Designation: <span class="remarque">*</span></td>
            <td align="center"> <input name="designation" type="text" class="champ"  id="designation">
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left">qte : </td>
            <td align="center"><input name="qte" type="text" class="champ" id="qte" />
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left">pu htva :</td>
            <td align="center"> <input name="puHT" type="text" class="champ" id="puHT">
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left">Remarque : </td>
            <td align="center"> <input name="rem" type="text" class="champ" id="rem" maxlength="20">
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
        </table></td>
    </tr>
        <tr>
    <td height="30" align="center">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center"><input name="numObjet" type="hidden" id="numObjet" value="<%=numObjet%>">
          <input name="nature" type="hidden" id="nature" value="<%=nature%>">
<input name="tableDet" type="hidden" id="nature" value="<%=tableDet%>">
          <input name="acte" type="hidden" id="acte" value="INSERT">
              <input type="submit" name="Submit" value="Enregistrer" class="submit">
			  <input type="submit" name="Submit" value="retour" class="submit">
          </td>
          <td align="center">
<input type="reset" name="annuler" value="R&eacute;tablir" class="submit">
          </td>
  </tr>
</table>

<h2>Detail du <%=nature%></h2>
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr class="head">

          <td width="66" align="center" valign="top">num</td>
                   <td width="153" align="right" valign="top"><div align="center">Designation</div></td>
          <td width="153" align="right" valign="top"><div align="center">Quantité</div></td>
          <td width="153" align="right" valign="top"><div align="center"><strong>PU </strong></div></td>
  <td width="102" align="center" valign="top">Remarque</td>
<td width="102" align="center" valign="top"></td>
        </tr>
        <%
          for(int i=0;i<detail.length;i++){
  %>
        <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">

          <td align="center"><%=detail[i].getId() %></td>
          <td align="right"><div align="center"><%=detail[i].getDesignation() %></div></td>
                  <td align="center"><div align="center"><%=detail[i].getQte() %></div></td>
          <td align="right"><div align="center"><%=detail[i].getPuHT() %></div></td>

         <td align="right"><div align="center"><%=detail[i].getRemarque() %></div></td>
                  <td align="center">

                    <div align="center">
          <input name="indice" type="hidden" id="numObjet" value="<%=i%>" onClick="nombre.value=<%=i%>">




          <%
          }
  %>
                    </div>
          </table>

    </td>
        </tr>
</table>










</form>
<div align="center">

  <span class="remarque">(*) Champs obligatoires</span></div>