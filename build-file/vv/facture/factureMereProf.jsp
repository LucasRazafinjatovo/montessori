<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/apresFactureMere.jsp";
	String lien= null;
	facture.Client clt = null;
	facture.SCatService sctserv[] = null;
	String idClient = null;
    String idTypeFacture = null;
    String date = null;
	facture.Tva tva = null;
	facture.Tva[] allTva=null;
	bean.TypeObjet dev[] = null;
	String idFactureMere = null;
	String dateDebut = null;
	UserEJB u = null;
	historique.MapUtilisateur ut=null;
	bean.TypeObjet typepaie[]= null;
	%>

	<%
	idClient = request.getParameter("idClient");
	dateDebut = request.getParameter("date");
	idTypeFacture= request.getParameter("idTypeFacture");
	%>

	<%
	try{
		u=(user.UserEJB)session.getValue("u");
		lien=(String)session.getValue("lien");
		ut=u.getUser();
		clt = u.findClient(idClient, "%", "%", "%", "%", "%", "%", "%", "%", "%", "%")[0];
		tva = u.loadTva(Utilitaire.dateDuJour());
		allTva=u.findTva("%","%","","");
		dev = u.findTypeObjet("Devise", "%", "%");
		typepaie = u.findTypeObjet("TypePaiement","%","%");
	}catch(Exception e){
	%>
		<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
	<%
	}
	%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Création nouvelle facture proforma(2)</h1>
<form action="<%=lien%>?but=<%=apres%>" method="post">
  <table cellspacing="0" cellpadding="0" align="center">


<tr>
<td width="450">
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <tr>
            <td height="25" valign="top" class="left">Date :</td>
            <td valign="top">&nbsp; <input name="textfield" type="text" class="champ" value="<%=request.getParameter("date")%>" disabled>
              <input name="date" type="hidden" id="date" value="<%=request.getParameter("date")%>">
              <span class="remarque">(dt cr&eacute;ation facture prof)</span></td>
          </tr>
          <tr>
            <td width="136" height="25" valign="top" class="left">Date d&eacute;but
              :</td>
            <td width="258" valign="top">&nbsp; <input name="dateDebut" type="text" class="champ" id="date" value="<%=request.getParameter("dateDebut")%>" size="10" maxlength="10" disabled>
              <input name="dateDebut" type="hidden" id="dateDebut" value="<%=request.getParameter("dateDebut")%>">
              <span class="remarque">(dt d&eacute;but facture prof)</span> </td>
          </tr>
          <tr>
            <td width="136" height="25" valign="top" class="left">Date fin :</td>
            <td width="258" valign="top">&nbsp; <input name="dateFin" type="text" class="champ" id="date" value="<%=request.getParameter("dateFin")%>" size="10" maxlength="10" disabled>
              <input name="dateFin" type="hidden" id="dateFin" value="<%=request.getParameter("dateFin")%>">
              <span class="remarque">(dt fin facture)</span></td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Nom du client :</td>
            <td valign="top">&nbsp; <input name="nomClient" type="text" disabled class="champ" id="nomClient" value="<%=clt.getNom()%>">
              <input name="idClient" type="hidden" value="<%=idClient%>"></td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Note explicative :</td>
            <td valign="top">&nbsp; <textarea name="note" cols="30" rows="5" id="note">-</textarea></td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Facture en :</td>
            <td valign="top">&nbsp; <select name="idFactureEn" class="champ" id="idFactureEn">
                <%
				for(int i=0;i<dev.length;i++){
				%>
                <option value="<%=dev[i].getId()%>" <%if(dev[i].getId().compareTo("Ar")==0)out.println("selected");%>><%=dev[i].getVal()%></option>
                <%
                                 }
				%>
              </select> </td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Devise en :</td>
            <td valign="top">&nbsp; <select name="idDeviseEn" class="champ" id="idDeviseEn">
                <%
				for(int i=0;i<dev.length;i++){
				%>
                <option value="<%=dev[i].getId()%>" <%if(dev[i].getId().compareTo("Ar")==0)out.println("selected");%>><%=dev[i].getVal()%></option>
                <%
                                 }
				%>
              </select> </td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">Type de paiement :</td>
            <td valign="top">&nbsp; <select name="idTypePaie" class="champ" id="idDeviseEn">
                <%
				for(int i=0;i<typepaie.length;i++){
				%>
                <option value="<%=typepaie[i].getId()%>"><%=typepaie[i].getVal()%></option>
                <%
                                 }
				%>
              </select> </td>
          </tr>

          <tr>
            <td height="23" valign="top" class="left">TVA :</td>
            <td valign="top">&nbsp; 
				<input name="idTva" type="text" class="champ" maxlength="3" value="<%=tva.getValTva()%>" 
					<%if(ut.getIdrole().compareTo("compta")==0 || ut.getIdrole().compareTo("controle")==0 || ut.getIdrole().compareTo("pilotage")==0 || ut.getIdrole().compareTo("audit")==0 || ut.getIdrole().compareTo("assistCom")==0) out.print("readonly");%>>
              %
              <input name="idTypeFacture" type="hidden" id="idTypeFacture2" value="<%=request.getParameter("idTypeFacture")%>"></td>
              <input name="agence" type="hidden" id="agence" value="<%=request.getParameter("agence")%>"></td>
              <input name="entite" type="hidden" id="entite" value="<%=request.getParameter("entite")%>"></td>
              <input name="parution" type="hidden" id="parution" value="<%=request.getParameter("parution")%>"></td>
          </tr>
          <tr>
            <td height="23" valign="top" class="left">R&eacute;duction :</td>
            <td valign="top">&nbsp; <input name="reduction" type="text"  class="champ" id="reduction2" value="0" size="3" maxlength="3"<%if(ut.getIdrole().compareTo("controle")==0 || ut.getIdrole().compareTo("pilotage")==0|| ut.getIdrole().compareTo("audit")==0) out.print("readonly");%>>
              %
              <input name="acte" type="hidden" id="acte2" value="INSERT"></td>
            <%
           		 if(ut.getIdrole().compareTo("controle")==0 || ut.getIdrole().compareTo("pilotage")==0|| ut.getIdrole().compareTo("audit")==0){
               out.println("<input name=\"idTva\" type=\"hidden\"  value=\"" + tva.getValTva() + "\">");
               out.println ("<input name=\"reduction\" type=\"hidden\"  class=\"champ\" id=\"reduction\" value=\"0\">");
             }
          %>
          </tr>
        </table>


</td>
</tr>
<tr>
      <td height="30" align="center">
        <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
            <td align="center">
  <%
           	 if(ut.getIdrole().compareTo("controle")==0 || ut.getIdrole().compareTo("pilotage")==0|| ut.getIdrole().compareTo("audit")==0){
%>
    <input name="Submit" type="submit" class="submit" value="Valide1">
  <%
             }else{
			 %>
                         <input name="typefact" type="hidden" value="proforma">
                         <input name="listepub" type="hidden" value="">
			 <input name="Submit" type="submit" class="submit" value="Valide2" >
			 <%
			 }
 %>

            </td>
            <td align="center">
<input name="Submit2" type="reset" class="submit" value="Annuler">
            </td>
  </tr>
</table>
      </td>
    </tr>
</table>

</form>
