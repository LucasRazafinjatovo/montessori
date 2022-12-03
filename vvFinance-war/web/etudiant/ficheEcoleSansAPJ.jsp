<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="finance/viserVir.jsp";
        String lien= null;
        UserEJB u = null;
        TypeObjet tyo[] = null;
        TypeObjet tys[] = null;
        TypeObjet dev[] = null;
        Client clt[] = null;
        TypeObjet mp[] =null;
		TypeObjet ag[] =null;
        Caisse caiss[] = null;
                SaisieVirement sVir=null;

     %>
<%

try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
tyo = u.findTypeObjet("TypeEntree","%","%");
tys=u.findTypeObjet("TypeSortie","%","%");
clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
mp = u.findTypeObjet("ModePaiement","%","%");
ag = u.findTypeObjet("Agence","%","%");
dev = u.findTypeObjet("Devise","%","%");
caiss = u.findCaisse("%","%","%","%");
// nomtable,id,dev,caisse1,caisse2,mode,daty1,daty2,apreW
SaisieVirement temp[]=u.findVirementNormale("saisievirementlettre",request.getParameter("idVir"),"%","%","%","%","","","");
if(temp.length==0) throw new Exception("VIrement non existante");
sVir=temp[0];
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Virement d'une caisse &agrave; une autre caisse</h1>
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
    <td class="remarque">Permet de faire un virement d'une caisse &agrave; une autre caisse</td>
</tr>
</table>
<h2>&nbsp;</h2>

<h2>&nbsp; </h2>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
          <tr>
            <td class="left">Date : <span class="remarque">*</span></td>
            <td align="center"> <%=Utilitaire.formatterDaty(sVir.getDaty())%>
              &nbsp;
            </td>
          </tr>
          <tr>
            <td class="left">Montant : <span class="remarque">*</span></td>
            <td align="center"><%=Utilitaire.formaterAr(sVir.getMontant())%>
            </td>
          </tr>
          <tr>
            <td class="left">Devise en : </td>
            <td align="center"> <%=sVir.getDevise()%>
            </td>
          </tr>
          <tr>
            <td class="left">Caisse de d&eacute;part : </td>
            <td align="center"> <%=sVir.getCaisseDep()%>
            </td>
          </tr>
          <tr>
            <td class="left">Caisse d'arriv&eacute;e : </td>
            <td align="center"> <%=sVir.getCaisseArr()%>
            </td>
          </tr>
          <tr>
            <td class="left">Mode de paiement : </td>
            <td align="center"> <%=sVir.getModePay()%>
            </td>
          </tr>
          <tr>
            <td class="left" valign="top">Remarque :</td>
            <td align="center">  <%=sVir.getRemarque()%>
            </td>
          </tr>
        </table></td>
	</tr>
	<tr>
    <td height="30" align="center">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center"><input name="numObjet" type="hidden" id="numObjet" value="<%=request.getParameter("idVir")%>">
             <%if(sVir.getVisa()==null){%>
			  <input type="submit" name="Submit" value="Viser" class="submit">
          	<%}%>
		  </td>
  </tr>
</table>
    </td>
	</tr>
</table>
</form>
<div align="center">

  <span class="remarque">(*) Champs obligatoires</span></div>
