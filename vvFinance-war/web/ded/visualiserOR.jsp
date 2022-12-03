<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="ded.OrdonnerPayement" %>
<%@ page import="ded.Visa" %>
<%@ page import="ded.OpLc" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="ded/apresVisualiserOrdonnerRecette.jsp";
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
String numObjet = null;
double montantObjet = 0.0;
OrdonnerPayement op = null;
boolean estVisable=false;
		   Visa vi=null;
                   OpLc[] listeLc=null;
     %>
<%
idFact=request.getParameter("idFacture");
String indiceSelection=request.getParameter("indice");
montantObjet = 0.0;

idFact=request.getParameter("idOP");
nature=request.getParameter("nature");if ((nature==null)||nature.compareTo("")==0) nature="factureF";

if(idFact == null) idFact = request.getParameter("id");
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
op=((OrdonnerPayement[])u.findOpPage("ordonnerRecetteLibelle", idFact, "%", "%", "","","","","%",1).getResultat())[0];
//op=u.findOr(idFact,"%","%","","","","","%")[0];
 montantObjet =  op.getMontant();
 estVisable=op.orEstVisable();
	vi=op.getVisaOr();
        OpLc crto=new OpLc();
        crto.setNomTable("OrLCCalc");
        crto.setId(idFact);
listeLc=(OpLc[])CGenUtil.rechercher(crto,null,null,"");
//System.out.print("op.orEstVisable()::"+op.orEstVisable()+"estVisable::"+estVisable+"::op.getPayement()::"+op.getPayement()+"::vi::"+vi);
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>Visualiser Ordonner Recette </h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">

         <tr>
           <td class="left">Or id : </td>
           <td align="center"><%=op.getId() %></td>
         </tr>
         <tr>
            <td width="34%" class="left">Facture num : <span class="remarque">*</span></td>
            <td width="66%" align="center"><a href="<%=lien%>?but=facture/visualiserFactureClient.jsp&idBC=<%=op.getDed_Id()%>"> <%=op.getDed_Id()%></a>
                          </td>
          </tr>

          <tr>
            <td class="left">Agence : <span class="remarque">*</span></td>
            <td align="center">      <%=op.getIdLigne()%>
                      </td>
          </tr>

          <tr>
            <td class="left">Montant (HT) : </td>
            <td align="center"><%=Utilitaire.formaterAr(op.getMontant())%>
                          </td>
          </tr>
          <tr>
            <td class="left">Designation : </td>
            <td align="center"> <%=op.getRemarque()%></td>
          </tr>
          <tr>
            <td class="left">Etat : </td>
            <td align="center"><%=op.getEtatLettre()%></td>
          </tr>
        </table></td>
    </tr>
    <tr>
		<td height="30" align="center">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center">
						<%if(vi==null){ %>
						<input type="submit" name="Submit2" value="attacher Lc" class="submit" onClick="acte.value='attach'">
						<%}%>
						<input name="nature" type="hidden" id="nature" value="<%=nature%>">
						<input name="idDED" type="hidden" id="idDED" value="<%=op.getDed_Id()%>">
						<input name="numObjet" type="hidden" id="numObjet" value="<%=op.getId()%>">
						<input name="montantObjet" type="hidden" id="montantObjet" value="<%=montantObjet%>">
						<input name="remarque" type="hidden" id="remarque" value="<%=op.getRemarque()%>">
						<input name="typeObjet" type="hidden" id="typeObjet" value="<%=nature%>">
						<input name="idLc" type="hidden" id="idLc" value="<%=op.getIdLigne()%>">

						<input name="acte" type="hidden" id="acte" value="viser">
						<input type="submit" name="Submit" value="Dupliquer" class="submit" onClick="acte.value='dupliquer'">&nbsp;
						<input type="submit" name="Submit" value="Modifier" class="submit" onClick="acte.value='modif'">&nbsp;
						<input type="submit" name="Submit" value="OR Prevision" class="submit" onClick="acte.value='prevision'">&nbsp;
						<!--<input type="submit" name="Submit" value="attacher prev" class="submit" onClick="acte.value='attachprev'">&nbsp;-->
						<%if(estVisable==true){
							// if(u.getUser().getLoginuser().compareToIgnoreCase("tahina")==0 || u.getUser().getLoginuser().compareToIgnoreCase("mamyvisa")==0 || u.getUser().getLoginuser().compareToIgnoreCase("lalanirina")==0 || u.getUser().getLoginuser().compareToIgnoreCase("assist")==0){
						%>
						<input type="submit" name="Submit" value="viser" class="submit" onClick="acte.value='viser'">&nbsp;
						<%//}
						//if(u.getUser().getLoginuser().compareToIgnoreCase("tahina")==0 || u.getUser().getLoginuser().compareToIgnoreCase("mamyvisa")==0 || u.getUser().getLoginuser().compareToIgnoreCase("lalanirina")==0){
						%>
						<input type="submit" name="Submit" value="Modifier" class="submit" onClick="acte.value='modif'">
						<%}
                            //}
						if((op.getPayement()==null)&&(vi!=null)){%>
						<input type="submit" name="Submit" value="Payer" class="submit" onClick="acte.value='payer'">&nbsp;<%}%>
						<%
						if(u.getUser().getLoginuser().compareToIgnoreCase("lalanirina")==0 || u.getUser().getLoginuser().compareToIgnoreCase("max")==0 || u.getUser().getLoginuser().compareToIgnoreCase("dev")==0){%>
						<input type="submit" name="Submit" value="annuler" class="submit" onClick="acte.value='annulerOr'">&nbsp;<%}%>
					</td>
				</tr>
			</table>
		</td>
    </tr>
</table>
LISTE DES LIGNES CREDITS RELATIFS<br>
<table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
	<tr class="head">
		<td width="20%" align="right"><div align="center">Designation</div></td>
        <td width="10%" align="right"><div align="center">entite  </div></td>
        <td width="10%" align="right"><div align="center">type </div></td>
        <td width="20%" align="right"><div align="center">Montant op avant  </div></td>
        <td width="20%" align="right"><div align="center">Montant apres </div></td>
        <td width="20%" align="right"><div align="center">Credit prevu </div></td>
	</tr>
	<%
	for(int y=0;y<listeLc.length;y++){
		double encours=listeLc[y].getMontant();
		if(vi!=null) encours=0;
		%>
	<tr>
		<td  align="right"><div align="center"><%=listeLc[y].getDesignationLc() %> </div></td>
        <td align="right"><div align="center"><%=listeLc[y].getIdEntite() %></div></td>
        <td  align="right"><div align="center"><%=listeLc[y].getIdTypeLigne()%></div></td>
        <td align="right"><div align="center"><%=Utilitaire.formaterAr(listeLc[y].getMontantVis()) %></div></td>
        <td  align="right"><div align="center"><%=Utilitaire.formaterAr(listeLc[y].getMontantVis()+encours)%></div></td>
		<td  align="right"><div align="center"><%=Utilitaire.formaterAr(listeLc[y].getCreditModifier()) %></div></td>
	</tr>
	<%}%>
</table>

</form>
<div align="center">
  <script language="javascript">

</script>
  <span class="remarque">(*) Champs obligatoires</span></div>