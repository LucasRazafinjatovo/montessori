<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="pub.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="bean.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.TypeObjet" %>
<%@page import="bean.ClassMAPTable"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/apresFactureInit.jsp";
	String lien= null;
	facture.Client clt[] = null;
	facture.SCatService sctserv[] = null;
        TypeObjet ag[] =null;
        TypeObjet ttva[] =null;
        TypeObjet enti[] =null;
	UserEJB u = null;
        String acte=null;
        Agence agence = null;
        Agence[] lag = null;
        Beneficiaire benef = null;
        Agence[] lbenef = null;
        FactureClient fc=null;
        Pucomplet pub=null;
        Pucompletid[] lpub=null;
        FactureMereProforma fm = null;
        FactureClient[] lfc=null;
        FactureMereProforma[] lfm = null;
        finance.ScatService scs=null;
        finance.ScatService[] lscs=null;
        Client client = null;
        Client[] lclient = null;
        String[] g = null;

        InvenduLibelleType invlbtp = null;
        InvenduLibelleType[] linvendu=null;
        int reduction = 0;
%>
<%
String listepub = "";
try{
	u=(user.UserEJB)session.getValue("u");
	acte = request.getParameter("acte");
	clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
	sctserv = u.findSCatService("%", "%", "%", "%");
	ag = u.findTypeObjet("Agence","%","%");
	ttva = u.findTypeObjet("typetva","%","%");
	enti = u.findTypeObjet("BENEFICIAIRE","%","%");
	lien=(String)session.getValue("lien");
	if(acte.compareTo("-")!=0 && acte.compareTo("pub")!=0 && acte.compareTo("invendu")!=0){
		fc=new FactureClient();
		fc.setNomTable("factureclientproformaviserbis");
		lfc = (FactureClient[])CGenUtil.rechercher(fc,null,null,"  and idfacturefournisseur='"+acte+"'");
		if(lfc.length==0)throw new Exception("facture proforma invalide");
		fm = new FactureMereProforma();
		lfm = (FactureMereProforma[])CGenUtil.rechercher(fm,null,null," and idfacturemere='"+lfc[0].getNumfact()+"'");
		agence = new Agence();
		lag = (Agence[])CGenUtil.rechercher(agence,null,null," and id='"+lfm[0].getResp()+"'");
		agence.setNomTable("BENEFICIAIRE");
		lbenef = (Agence[])CGenUtil.rechercher(agence,null,null," and id='"+lfm[0].getEntite()+"'");
		scs=new finance.ScatService();
		lscs = (finance.ScatService[])CGenUtil.rechercher(scs,null,null," and idscatservice='"+lfm[0].getIdscatservice()+"'");
		client = new Client();
		lclient = (Client[])CGenUtil.rechercher(client,null,null," and idclient='"+lfm[0].getIdClient()+"'");
                System.out.println("LCLIENT ===>"+lclient);
		reduction = lfm[0].getReduction();
	}
	if(acte.compareTo("pub")==0){
		String[] idInv = request.getParameterValues("id");
		// request.removeAttribute("id");
		// g = Utilitaire.split(listepub,",");
		for(int i=0;i<idInv.length;i++)
		{
			String temp = "";
			listepub += idInv[i]+",";

		}
		g = idInv;
		Pucompletid pub = new Pucompletid();

		lpub = (Pucompletid[])CGenUtil.rechercher(pub,null,null,"  and id = '"+idInv[0]+"'");
		//if(lpub.length==0)throw new Exception("publicite invalide");
		agence = new Agence();
		agence.setNomTable("BENEFICIAIRE");
		lbenef = (Agence[])CGenUtil.rechercher(agence,null,null," and val='"+lpub[0].getLibJournal()+"'");
	}
	if(acte.compareTo("invendu")==0){
		String[] idInv = request.getParameterValues("id");
		// request.removeAttribute("id");
		for(int i=0;i<idInv.length;i++)
		{
			String temp = "";
			if(idInv[i].startsWith("INV")){

				listepub += idInv[i]+",";
			}

		}
		g = Utilitaire.split(listepub,",");
	}
}
catch(Exception e){
	e.printStackTrace();
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  }
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Cr&eacute;er une nouvelle facture (1)</h1>
<form action="<%=lien%>?but=facture/factureInit.jsp" method="post">
<p ><%if(acte.compareTo("pub")!=0 && acte.compareTo("invendu")!=0){%>A partir facture client proforma N�:&nbsp;<input name="acte" value="<%=acte%>" type="text" class="champ" id="acte" size="10" maxlength="10">&nbsp;&nbsp;<input type="submit" name="Submit" value="Valider" class="submit"><%}%></p>
</form>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="factureInit" id="factureInit">
<%if(acte.compareTo("")==0 || acte==null){
  acte="-";
}%>
<table width="500" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td align="center"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
        <tr>
			<td width="33%" class="left" height="23"> &nbsp;Date :</td>
            <td width="10%">&nbsp;</td>
            <td width="57%"><input name="date" type="text" class="champ" id="date" value="<%=Utilitaire.dateDuJour()%>" size="10" maxlength="10" onBlur="cal_prs_date1(date.value)">
              <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
              <span class="remarque">(date cr&eacute;ation facture)</span></td>
        </tr>
        <tr>
            <td height="23" class="left"> &nbsp;Date d&eacute;but :</td>
            <td>&nbsp;</td>
            <td><input name="dateDebut" type="text" class="champ" id="dateDebut" value="<%=Utilitaire.dateDuJour()%>" size="10" maxlength="10" onBlur="cal_prs_date1(dateDebut.value)">
              <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
              <span class="remarque">(date debut facture)</span></td>
        </tr>
      </td>
</table>
</form>
<p align="center">&nbsp;</p>
<script language="javascript">
var cal1 = new calendar1(document.forms['factureInit'].elements['date']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['factureInit'].elements['dateDebut']);
cal2.year_scroll = false;
cal2.time_comp = false;
var cal3 = new calendar1(document.forms['factureInit'].elements['dateFin']);
cal3.year_scroll = false;
cal3.time_comp = false;
</script>
