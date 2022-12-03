<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="prevision.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
	String apres="prevision/apresOpPrev.jsp";
	String lien= null;
	facture.Client clt[] = null;
	UserEJB u = null;
	TypeObjet tyo[] = null;
	TypeObjet dev[] = null;
	TypeObjet mp[] =null;
	TypeObjet source[] =null;
	TypeObjet ag[] =null;
	Caisse caiss[] = null;
	facture.Tva tva = null;
	String nature=null;
	String numObjet = null;
	String idLigne= null;
	String designation="";
	String[] temps=null;
	PrevDepenseLib prec = null;
	PrevDepenseLib[] lprec = null;
    %>
	<%
numObjet = (String)session.getValue("listePrev");
idLigne = request.getParameter("idLigne");
nature=request.getParameter("nature");if ((nature==null)||nature.compareTo("")==0) nature="factureF";
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
designation="";
prec = new PrevDepenseLib();
prec.setNomTable("prevdepenselib");
prec.setId(request.getParameter("idprev"));
  lprec = (PrevDepenseLib[])CGenUtil.rechercher(prec,null,null,"");
  designation = designation+" "+lprec[0].getRemarque();
dev = u.findTypeObjet("Devise","%","%");
ag = u.findTypeObjet("Agence","%","%");
}catch(Exception e){
e.printStackTrace();
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>Ordonner Paiement Prev</h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
		<tr>
            <td class="left">Date : </td>
            <td align="center"><input name="daty" type="text" class="champ" id="daty" value=<%=Utilitaire.dateDuJour() %> /></td>
            <td align="left">&nbsp;
              <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
              <img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
        </tr>
		<tr>
			<td class="left">Designation : </td>
			<td align="center"><textarea name="remarque" width="250" height="100" id="remarque" maxlength="200"><%=designation%></textarea></td>
			<td align="center">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"> </td>
		</tr>
        <tr>
            <td class="left">Montant : </td>
            <td align="center"><input name="montantTTC" type="text" class="champ" id="montantTTC" value="<%=request.getParameter("montant")%>"/></td>
            <td align="center">&nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
        </tr>
        <tr>
            <td class="left">Num OP : <span class="remarque">*</span></td>
            <td align="center">
              <input type="text" class="champ" name="numop" />
			&nbsp; </td>
            <td align="center"><input name="choix3" type="button" class="submit" onclick="pagePopUp('listeOPChoix.jsp?champReturn=numop')" value="..." />
            <img src="images/blank.gif" width="16" height="16" align="absmiddle"></td>
        </tr>
		<input type="hidden" class="champ" name="lc" value=""/>
        <tr>
            <td class="left">Selon prevision : <span class="remarque">*</span></td>
            <td align="center">          <input type="text" class="champ" name="prevision" value="<%=request.getParameter("idprev")%>"/>
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
        </tr>

	</table></td>
</tr>
	<tr>
		<td height="30" align="center"><table width="75%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td align="center">
					<input name="nature" type="hidden" id="nature" value="<%=nature%>">
					<input name="typeOp" type="hidden" id="typeOp" value="<%=Constante.typeOpNormale%>">
					<input name="acte" type="hidden" id="acte" value="attacheropprev">
					<input name="typeor" type="hidden" id="typeor" value="prev">
					<input name="avecOp" type="hidden" id="acte" value="ok">
					<input type="submit" name="Submit" value="Enregistrer" class="submit">
				</td>
				<td align="center">
					<input type="reset" name="annuler" value="R&eacute;tablir" class="submit">
				</td>
			</tr>
		</table></td>
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