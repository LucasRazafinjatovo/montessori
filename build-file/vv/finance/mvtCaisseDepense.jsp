<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="ded.Ded" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="finance/apresMvtCaisseDirecte.jsp";
        String lien= null;

        UserEJB u = null;

  TypeObjet mp[] =null;

  Caisse caiss[] = null;
   TypeObjet dev[] =null;

String nature = null;
String numPiece= null;
String numObjet=null;
 String typeObjet = null;
 String montantObjet= null;
 String debit = null;
 String credit = null;
     %>
<%


  numObjet=request.getParameter("numObjet");
 typeObjet = request.getParameter("typeObjet");
 montantObjet= request.getParameter("montantObjet");


try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
mp = u.findTypeObjet("modepaiement","%","%");
caiss = u.findCaisse("%","%","%","%");
dev = u.findTypeObjet("Devise","%","%");


}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>MOUVEMENT CAISSE DEPENSE </h1>
<h2>&nbsp;</h2>


<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
 <tr>
            <td class="left">Id. Ligne : <span class="remarque">*</span></td>
            <td align="center"> <input name="idLigne" type="text" class="champ" id="idLigne" value="">
&nbsp;            </td>
            <td align="center"><input name="choix3" type="button" onClick="pagePopUp('lc/choix_LC.jsp?champReturn=idLigne')" value="..." class="submit">  </td>
          </tr>
		   <tr>
            <td class="left">Facture fournisseur: <span class="remarque">*</span></td>
            <td align="center"> <input name="idFacture" type="text" class="champ" id="idFacture" value="">
&nbsp;            </td>
            <td align="center"><input name="choix3" type="button" onClick="pagePopUp('facturefournisseur/choix_ff.jsp?champReturn=idFacture')" value="..." class="submit">  </td>
          </tr>
          <tr>
            <td class="left">Date : <span class="remarque">*</span></td>
            <td align="center"> <input name="daty" type="text" class="champ" id="date" value="<%=Utilitaire.dateDuJour()%>">
&nbsp;            </td>
            <td align="center"><a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
          </tr>
		   <tr>
            <td class="left">Designation : <span class="remarque">*</span></td>
            <td align="center"> <input name="designation" type="text" class="champ" id="designation" value=""> </td>
            <td align="center">&nbsp;</td>
	      </tr>
		    <tr>
            <td class="left">Debit : <span class="remarque">*</span></td>
            <td align="center"> <input name="debit" type="text" class="champ" id="debit" value=""> </td>
            <td align="center">&nbsp;</td>
	      </tr>
		   <tr>
            <td class="left">Credit : <span class="remarque">*</span></td>
            <td align="center"> <input name="credit" type="text" class="champ" id="credit" value=""> </td>
            <td align="center">&nbsp;</td>
	      </tr>
		  <tr>
            <td class="left">Devise : <span class="remarque">*</span></td>
            <td align="center"> <select name="idDevise" class="champ" id="idDevise">
                <option value="Ar">Ar</option>
                <%
for(int i=0;i<dev.length;i++){
%>
                <option value="<%=dev[i].getId()%>"><%=dev[i].getVal()%></option>
                <%
}
%>
              </select> </td>
            <td align="center">&nbsp;</td>
		  </tr>
		  <tr>
            <td class="left">Mode : <span class="remarque">*</span></td>
            <td align="center"> <select name="idMode" class="champ" id="idMode">

                <%
for(int i=0;i<mp.length;i++){
%>
                <option value="<%=mp[i].getId()%>"><%=mp[i].getVal()%></option>
                <%
}
%>
              </select> </td>
            <td align="center">&nbsp;</td>
		  </tr>
		   <tr>
            <td class="left">Caisse : <span class="remarque">*</span></td>
            <td align="center"> <select name="idCaisse" class="champ" id="idCaisse">

                <%
for(int i=0;i<caiss.length;i++){

%>
                <option value="<%=caiss[i].getIdCaisse()%>"><%=caiss[i].getDescCaisse()%></option>
                <%
}
%>
              </select> </td>
            <td align="center">&nbsp;</td>
	      </tr>
		   <tr>
            <td class="left">Remarque : <span class="remarque">*</span></td>
            <td align="center"> <input name="remarque" type="text" class="champ" id="remarque" value=""> </td>
            <td align="center">&nbsp;</td>
	      </tr>
                            <tr>
            <td class="left">numero Pi�ce : <span class="remarque"></span></td>
            <td align="center"> <input name="numPiece" type="text" class="champ" id="numPiece" value=""> </td>
            <td align="center">&nbsp;</td>
	      </tr>
		   <tr>
            <td class="left">Agence : <span class="remarque">*</span></td>
            <td align="center"> <input name="agence" type="text" class="champ" id="agence" value=""> </td>
            <td align="center">&nbsp;</td>
	      </tr>
          <tr>
            <td class="left">Tiers: <span class="remarque">*</span></td>
            <td align="center">              <input name="tiers" type="text" class="champ" value=""/>
            &nbsp;
            </td>
            <td align="center"><input name="choix3" type="button" onClick="pagePopUp('ded/choix_tiers.jsp?champReturn=tiers')" value="..." class="submit">              </td>
          </tr>


        </table></td>
    </tr>
        <tr>
    <td height="30" align="center">



	  <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center"><input name="nature" type="hidden" id="nature" value="<%=nature%>">
 <input name="typeObjet" type="hidden" id="typeObjet" value="<%=typeObjet%>">
   <input name="numObjet" type="hidden" id="numObjet" value="<%=numObjet%>">
          <input name="acte" type="hidden" id="acte" value="INSERT">
              <input type="submit" name="Submit" value="Enregistreer" class="submit">
          </td>

  </tr>
</table>


    </td>
        </tr>
</table>










</form>
<div align="center">
  <script language="javascript">
var cal1 = new calendar1(document.forms['recette'].elements['daty']);
cal1.year_scroll = false;
cal1.time_comp = false;
</script>
  <span class="remarque">(*) Champs obligatoires</span></div>