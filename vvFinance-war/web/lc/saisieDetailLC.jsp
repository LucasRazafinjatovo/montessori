<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="lc.LcDetail" %>
<%@ page import="lc.LigneCreditComplet"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="lc/apresSaisieDetailLC.jsp";
		//String apresChoix ="lc/modifLC.jsp";
        UserEJB u = null;
        LcDetail lcDetail[] = null;
        LigneCreditComplet l = null;

        String lien= null;
        String apresChoix="lc/modifDetailLC.jsp";
String nature ="Créer";
        String numObjet = null;

			 /*   facture.Client clt[] = null;

        TypeObjet tyo[] = null;
        TypeObjet dev[] = null;
        TypeObjet mp[] =null;
        TypeObjet source[] =null;
                TypeObjet ag[] =null;
        Caisse caiss[] = null;
                String idFact = null;
                facture.Tva tva = null;
				String nature=null;
				String idMere=null;*/

String readOnly = "";
     %>
<%
nature ="Créer";
numObjet=request.getParameter("numObjet");
nature=request.getParameter("nature");

try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");

 //l = u.findLCComplet(numObjet,"","","","","","","","","","idLigne","ASC","")[0];
 //LcDetail[] findDetailLc(String id, String idLC, String compteDet, String etat)
 lcDetail = u.findDetailLc("%",numObjet,"%","%");
 /*if(l.getCreditInitial()==0){
 readOnly="readonly";
 }*/
//Inserer methode
/*tyo = u.findTypeObjet("TypeEntree","%","%");
clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
mp = u.findTypeObjet("ModePaiement","%","%");
ag = u.findTypeObjet("Agence","%","%");
dev = u.findTypeObjet("Devise","%","%");
source = u.findTypeObjet("Beneficiaire","%","%");
caiss = u.findCaisse("%","%","%","%");*/

}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>Saisie detail ligne de credit<%=numObjet%> </h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>


<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> 

<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">

         <tr>
            <td class="left">compte Detail: <span class="remarque">*</span></td>
            <td align="center"> <input name="designation" type="text" class="champ"  id="designation">
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left">Credit : </td>
            <td align="center"><input name="credit" <%=readOnly%>type="text" class="champ" id="credit" />
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left">Montant eng  :</td>
            <td align="center"> <input name="montEng" <%=readOnly%> type="text" class="champ" id="montEng">
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left">Montant vis&eacute;  : </td>
            <td align="center"> <input name="montVis" type="text"<%=readOnly%> class="champ" id="montVis" maxlength="20">
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
		   <tr>
            <td class="left">Montant Fact  :</td>
            <td align="center"> <input name="pu" type="text" <%=readOnly%>  class="champ" id="pu">
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
        </table>
        
        <table width="75%" border="0" cellspacing="0" cellpadding="0">
  		<tr>
          <td align="center"><input name="numObjet" type="hidden" id="numObjet" value="<%=numObjet%>">
          <input name="nature" type="hidden" id="nature" value="">
          <input name="acte" type="hidden" id="acte" value="INSERT">
          <input type="submit" name="Submit" value="Enregistrer" class="submit" /></td>
          <td align="center">
<input type="reset" name="annuler" value="R&eacute;tablir" class="submit">          </td>
	  </tr>
	</table>  
	
	</form>	
		</td>
    </tr>
        
		<tr>
    <td height="30" align="center">
    
	
  
<h2>Liste detail ligne de crédit </h2>

<form action="<%=lien%>?but=<%=apresChoix%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr class="head">
				<td width="102" align="center" valign="top"></td>
          		<td width="66" align="center" valign="top">id</td>
                <td width="153" align="right" valign="top"><div align="center">compteDetail</div></td>
          		<td width="153" align="right" valign="top"><div align="center">credit</div></td>
				<td width="153" align="right" valign="top"><div align="center"><strong>montant Eng </strong></div></td>
				<td width="153" align="right" valign="top"><div align="center"><strong>montant vis </strong></div></td>
				<td width="102" align="center" valign="top">Montant Fact</td>
				<td width="102" align="center" valign="top">suppr</td>
        </tr>
        <%
  for(int i=0;i<lcDetail.length;i++){
  %>
        <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
 <td align="center">

 <input name="indiceObjetFils" type="radio" id="numObjetFils" value="<%=i%>">
<input type="hidden" name="numObjetFils<%=i%>" value="<%=lcDetail[i].getId()%>">
</td>
          <td align="center"><%=lcDetail[i].getId()%></td>
          <td align="right"><%=lcDetail[i].getCompteDetail()%></td>
                  <td align="center"><%=lcDetail[i].getCredit()%></td>
          <td align="right"><%=lcDetail[i].getMontantEng()%></td>

         <td align="right"><%=lcDetail[i].getMontantVis()%></td>
   <td align="right"><%=lcDetail[i].getMontantFact()%></td>
                  <td align="center">
<input name="numObjet" type="hidden" id="numObjet" value="<%=numObjet%>">
<input name="indice" type="hidden" id="numObjet" value="<%=i%>" onClick="nombre.value=<%=i%>">
<input type="hidden" name="numObjetFils<%=i%>" value="">
</td>

</tr>

        <%
    }
  %>
  
      </table>
</form>



   </td>
   </tr>
   </table>



<div align="center">
  
  <span class="remarque">(*) Champs obligatoires</span></div>