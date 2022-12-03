<%@ page import="user.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="bean.*" %>
<%@page import="bean.ClassMAPTable"%>
<%@ page import="utilitaire.*" %>
<%@ page import="compterendu.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%!
    UserEJB u = null;
    String lien= null;
    CompteRenduOrEntiteDirection cod=null;
    CompteRenduOrEntiteDirection[] lcod=null;
    CompteRenduOp cop=null;
    CompteRenduOp[] lcop=null;
    CompteRenduLcd crlc=null;
    CompteRenduLcd[] lcrlc=null;
    CompteRenduDistribution crdist=null;
    CompteRenduDistribution[] lcrdist=null;
    CompteRenduDistributionRecette crdistrec=null;
    CompteRenduDistributionRecette[] lcrdistrec=null;
    CompteRenduDistributionRecette[] lcrdistrectana=null;
    CompteRenduDistributionImpaye crdistimp = null;
    CompteRenduDistributionImpaye[] lcrdistimp = null;
    CompteRenduDistributionImpaye[] lcrdistimpprov = null;
    CompteRenduDistributionImpaye[] lcdrdistimpmois= null;
    CompteRenduDistributionImpaye[] listlcdrdistimpmois= null;
    CompteRenduDistributionImpaye[] lcdrdistimpmoisprov= null;
    CompteRenduDistributionImpaye[] listlcdrdistimpmoisprov= null;
    CompteRenduCommercial crpub = null;
    CompteRenduCommercial[] lcrpub = null;
    CompteRenduCommercialImpaye crcomimpaye = null;
    CompteRenduCommercialImpaye[] lcrcomimpayemois = null;
    CompteRenduCommercialImpaye[] lcrcomimpayean = null;
    String currentDate1 = null;
    String currentDate2 = null;
    int currentMonth = 0;
    int currentYear = 0;
    int prevYear = 0;
	String finance = "";
	String distribution = "";
	String commercial = "";
%>
<%
try{
	
    currentDate1 = (request.getParameter("date1")!=null)? request.getParameter("date1"):Utilitaire.dateDuJour();
    currentDate2 = (request.getParameter("date2")!=null)? request.getParameter("date2"):Utilitaire.dateDuJour();
    //currentDate ="07/04/2014";
    currentMonth = Integer.parseInt((Utilitaire.dateDuJour()).substring(3,5))-1;
    currentYear = Integer.parseInt((Utilitaire.dateDuJour()).substring(6,10));
    prevYear = currentYear-1;
    u=(user.UserEJB)session.getValue("u");
    lien=(String)session.getValue("lien");
    
	
	
	finance = (request.getParameter("finance")!=null)? request.getParameter("finance"):"unchecked";
	distribution = (request.getParameter("dist")!=null)? request.getParameter("dist"):"unchecked";
	commercial = (request.getParameter("comm")!=null)? request.getParameter("comm"):"unchecked";
	
	if(finance.compareToIgnoreCase("unchecked") != 0){
	
		cod=new CompteRenduOrEntiteDirection();
		cod.setNomTable("CompteRenduOrEntiteDirection");
		lcod=(CompteRenduOrEntiteDirection[])CGenUtil.rechercher(cod,null,null," and daty between '"+currentDate1+"' and '"+currentDate2+"'");
		
		cop=new CompteRenduOp();
		cop.setNomTable("CompteRenduOp");
		lcop = (CompteRenduOp[])CGenUtil.rechercher(cop,null,null," and daty between '"+currentDate1+"' and '"+currentDate2+"'");
		
		crlc=new CompteRenduLcd();
		crlc.setNomTable("CompteRenduLcd");
		lcrlc=(CompteRenduLcd[])CGenUtil.rechercher(crlc,null,null,"");
	}
	if(distribution.compareToIgnoreCase("unchecked") != 0){
	
		crdist = new CompteRenduDistribution();
		crdist.setNomTable("CompteRenduDistribution");
		lcrdist = (CompteRenduDistribution[])CGenUtil.rechercher(crdist,null,null, " and daty between '"+currentDate1+"' and '"+currentDate2+"'");
		
		crdistrec = new CompteRenduDistributionRecette();
		lcrdistrectana = (CompteRenduDistributionRecette[])CGenUtil.rechercher(crdistrec,null,null," and daty between '"+currentDate1+"' and '"+currentDate2+"' and province='tana'");
		lcrdistrec = (CompteRenduDistributionRecette[])CGenUtil.rechercher(crdistrec,null,null," and daty between '"+currentDate1+"' and '"+currentDate2+"' and province='province'");
		crdistimp = new CompteRenduDistributionImpaye();
		lcrdistimp = (CompteRenduDistributionImpaye[])CGenUtil.rechercher(crdistimp,null,null," and annee='"+prevYear+"' and province='tana'");
		lcdrdistimpmois = (CompteRenduDistributionImpaye[])CGenUtil.rechercher(crdistimp,null,null," and annee='"+currentYear+"'and mois<='"+currentMonth+"' and province='tana' order by mois asc");
		lcrdistimpprov = (CompteRenduDistributionImpaye[])CGenUtil.rechercher(crdistimp,null,null," and annee='"+prevYear+"' and province='province'");
		lcdrdistimpmoisprov = (CompteRenduDistributionImpaye[])CGenUtil.rechercher(crdistimp,null,null," and annee='"+currentYear+"'and mois<='"+currentMonth+"' and province='province' order by mois asc");
		
	}
	if(commercial.compareToIgnoreCase("unchecked") != 0){
		crpub = new CompteRenduCommercial();
		lcrpub = (CompteRenduCommercial[]) CGenUtil.rechercher(crpub,null,null," and daty between ('"+currentDate1+"' and '"+currentDate2+"')");
		crcomimpaye=new CompteRenduCommercialImpaye();
		lcrcomimpayemois = (CompteRenduCommercialImpaye[])CGenUtil.rechercher(crcomimpaye,null,null," and annee='"+currentYear+"'and mois<='"+currentMonth+"' order by mois asc");
		lcrcomimpayean = (CompteRenduCommercialImpaye[])CGenUtil.rechercher(crcomimpaye,null,null," and annee='"+prevYear+"'");
	}

}
catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  }
%>
<SCRIPT language="JavaScript" src="script.js"></script>
 
<link href="style.css" rel="stylesheet" type="text/css">
<p align="center">
    <strong><u>COMPTE RENDU JOURNALIER du <%=currentDate1%> au <%=currentDate2%></u></strong>
</p>

 <form action="<%=lien%>?but=compte/compteRendu.jsp" method="post" name="client" id="client" target="_parent">

  <table width="600" border="0" align="center" cellpadding="0"
          cellspacing="0">
			
          <tr>
                  <td>
                  <table width="100%" border="0" align="center" cellpadding="2"
                          cellspacing="0" class="monographe">
                          <tr>
                            <td class="left" width="20%" valign="top"><div align="center">Date inf:<span class="remarque">*</span></div></td>
                            <td align="center" width="30%"><input type="text" name="date1" class="champ" id="date1" value=<%=currentDate1%> />
							<td class="left" width="20%" valign="top"><div align="center">Date sup:<span class="remarque">*</span></div></td>
                            <td align="center" width="30%"><input type="text" name="date2" class="champ" id="date2" value=<%=currentDate2%> />
                          </tr>
                  </table>
                  </td>
          </tr>
		  <tr>
                <td>
					<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
                          <tr>
                            <td class="left" width="20%" valign="top"><div align="center">A afficher:<span class="remarque">*</span></div></td>
                            <td align="center" width="30%">
								<table><tr>
									<td>Finance<input type="checkbox" name="finance" class="champ" value="finance" id="finance"/></td>
									<td>Distribution<input type="checkbox" name="dist" class="champ" value="dist" id="dist" /></td>
									<td>Commercial<input type="checkbox" name="comm" class="champ" value="comm" id="comm" /></td>
								</tr></table>
							</td>
                          </tr>
					</table>
                </td>
          </tr>
          <tr>
                  <td height="30" align="center">
                  <table width="75%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td align="center"><input type="submit" name="Submit"  class="submit" value="Valider"></td>
                            <td align="center"><input type="reset" name="annuler"   value="R&eacute;;tablir" class="submit"></td>
                          </tr>
                  </table>
                  </td>
          </tr>
          <input type="hidden" name="acte"   value="" class="submit">
          <input type="hidden" name="bute"   value="compte/compteRendu.jsp" class="submit">
  </table>
  </form>

  
  
  
  
  
  
  
  
  
  <%
	if(finance.compareToIgnoreCase("unchecked") != 0){
		
		%>		
		<p>
			<strong>1. </strong>
			<strong>Rapport financier</strong>
		</p>
		<p>
			<u>Recette</u>
		</p>
		<table border="1" cellpadding="0" cellspacing="0">
			<tbody>
				<tr>
					<td valign="top" width="205">
						<p align="center">
							<strong>Date</strong>
						</p>
					</td>
					<td valign="top" width="205">
						<p align="center">
							<strong>Entit&eacute;</strong>
						</p>
					</td>
					<td valign="top" width="205">
						<p align="center">
							<strong>Direction</strong>
						</p>
					</td>
					<td valign="top" width="205">
						<p align="center">
							<strong>montant</strong>
						</p>
					</td>
				</tr>
				<%for(int i=0;i<lcod.length;i++){%>
				<tr>
					<td align="center" width="205"><%=lcod[i].getDaty()%></td>
					<td align="center" width="205"><%=lcod[i].getEntite()%></td>
					<td align="center" width="205"><%=lcod[i].getDirection()%></td>
					<td align="center" width="205"><%=Utilitaire.formaterAr(lcod[i].getMontant())%></td>
				</tr>
				<%}%>
			</tbody>
		</table>
		<p>
			<strong> </strong>
		</p>
		<p>
			<u>D&eacute;pense (par montant descendant)</u>
		</p>
		<table border="1" cellpadding="0" cellspacing="0">
			<tbody>
				<tr>
					<td valign="top" width="307">
						<p align="center">
							<strong>D&eacute;signation</strong>
						</p>
					</td>
					<td valign="top" width="307">
						<p align="center">
							<strong>Montant</strong>
						</p>
					</td>
				</tr>
				<%for(int j=0;j<lcop.length;j++){%>
				<tr>
					<td align="center" width="307"><%=lcop[j].getDesignation()%></td>
					<td align="center" width="307"><%=Utilitaire.formaterAr(lcop[j].getMontant())%></td>
				</tr>
				<%}%>
			</tbody>
		</table>
		<p>
			<u> </u>
		</p>
		<p>
			<u>Ligne cr&eacute;dit d&eacute;pense hors budget (liste ligne cr&eacute;dit dont le montant engag&eacute; est sup&eacute;rieur au cr&eacute;dit initial</u>
		</p>
		<table border="1" cellpadding="0" cellspacing="0">
			<tbody>
				<tr>
					<td valign="top" width="307">
						<p align="center">
							<strong>Ligne cr&eacute;dit</strong>
						</p>
					</td>
					<td valign="top" width="307">
						<p align="center">
							<strong>Mois</strong>
						</p>
					</td>
					<td valign="top" width="307">
						<p align="center">
							<strong>Ann&eacute;e</strong>
						</p>
					</td>
					<td valign="top" width="307">
						<p align="center">
							<strong>Montant du d&eacute;passement</strong>
						</p>
					</td>
				</tr>
				<%for(int k=0;k<lcrlc.length;k++){%>
				<tr>
					<td align="center" width="307"><%=lcrlc[k].getDesignation()%></td>
					<td align="center" width="307"><%=lcrlc[k].getMois()%></td>
					<td align="center" width="307"><%=lcrlc[k].getAnnee()%></td>
					<td align="center" width="307"><%=Utilitaire.formaterAr(lcrlc[k].getMontantdepassement())%></td>
				</tr>
				<%}%>
			</tbody>
		</table>
		<p>
			<strong> </strong>
		</p>
		<%
		
	}
	if(distribution.compareToIgnoreCase("unchecked") != 0){
		%>
		
		<p>
			<strong>2. </strong>
			<strong><u>Rapport Distribution</u></strong>
		</p>
		<table border="1" cellpadding="0" cellspacing="0">
			<tbody>
				<tr>
					<td valign="top" width="94">
						<p align="center">
							<strong>Gazety</strong>
						</p>
					</td>
					<td valign="top" width="82">
						<p align="center">
							<strong>Titre</strong>
						</p>
					</td>
					<td valign="top" width="84">
						<p align="center">
							<strong>Heure arriv&eacute;e</strong>
						</p>
					</td>
					<td valign="top" width="96">
						<p align="center">
							<strong>Produit : nbre exemplaire</strong>
						</p>
					</td>
					<td valign="top" width="86">
						<p align="center">
							<strong>Prise Tana</strong>
						</p>
					</td>
					<td valign="top" width="91">
						<p align="center">
							<strong>Vente Tana</strong>
						</p>
					</td>
				</tr>
				<%for(int x=0;x<lcrdist.length;x++){%>
				<tr>
					<td valign="top" width="94"><%=lcrdist[x].getJournal()%></td>
					<td valign="top" width="82"><%=lcrdist[x].getTitre()%></td>
					<td valign="top" width="84"><%=lcrdist[x].getHeure()%></td>
					<td valign="top" width="96"><%=lcrdist[x].getNbreexemplaire()%></td>
					<td valign="top" width="86"><%=lcrdist[x].getPrise()%></td>
					<td valign="top" width="91"><%=lcrdist[x].getVente()%></td>
				</tr>
				<%}%>
			</tbody>
		</table>
		<p>
			<u>Recette</u>
		</p>
		<table border="1" cellpadding="0" cellspacing="0">
			<tbody>
				<tr>
					<td valign="top" width="149">
						<p align="center">
							<strong>Vente</strong>
						</p>
					</td>
					<td valign="top" width="260">
						<p align="center">
							<strong>Montant</strong>
						</p>
					</td>
				</tr>
				<tr>
					<td valign="top" width="149">
						<p>
							Venta Tana
						</p>
					</td>
					<td valign="top" width="260">
						<% try{
							String montant = null;
							montant = Utilitaire.formaterAr(lcrdistrectana[0].getMontantrecette());
							out.println(montant);
						}
						catch(Exception e){
							out.println(0);
						}%>
					</td>
				</tr>
				<tr>
					<td valign="top" width="149">
						<p>
							Vente province
						</p>
					</td>
					<td valign="top" width="260">
						<% try{
							String montant = null;
							montant =Utilitaire.formaterAr(lcrdistrec[0].getMontantrecette());
							out.println(montant);
						}
						catch(Exception e){
							out.println(0);
						}%>
					</td>
				</tr>
			</tbody>
		</table>
		<p>
			<u>Impay&eacute;:</u>
		</p>
			<li>
				Tana
			</li>
		<table border="1" cellpadding="0" cellspacing="0">
			<tbody>
				<tr>
					<td valign="top" width="307">
						<p align="center">
							<strong>P&eacute;riode</strong>
						</p>
					</td>
					<td valign="top" width="307">
						<p align="center">
							<strong>Montant</strong>
						</p>
					</td>
				</tr>
				<tr>
					<td valign="top" width="307">
						<p>
						<% try{
							int annee = 0;
							annee = lcrdistimp[0].getAnnee();
							out.println(annee);
						}
						catch(Exception e){
							out.println(0);
						}%>
						</p>
					</td>
					<td valign="top" width="307">
						<% try{
								String montant = null;
								montant = Utilitaire.formaterAr(lcrdistimp[0].getMontantimpaye());
								out.println(montant);
						}
						catch(Exception e){
							out.println(0);
						}%>
					</td>
				</tr>
				<%for(int m=lcdrdistimpmois.length;m>0;m--){%>
				<tr>
				  <td valign="top" width="307">
						<p>
						<% try{
							int mois = 0;
							mois = (lcdrdistimpmois[m-1]!=null)?lcdrdistimpmois[m-1].getMois():0;
							out.println(mois);
						}
						catch(Exception e){
							out.println(0);
						}%>
						</p>
					</td>
					<td valign="top" width="307">
						<% try{
							String montant = null;
							montant =Utilitaire.formaterAr( ((lcdrdistimpmois[m-1]!=null)?lcdrdistimpmois[m-1].getMontantimpaye():0));
							out.println(montant);
						}
						catch(Exception e){
							out.println(0);
						}
						%>
					</td>
				  </tr>
				  <%}%>
			</tbody>
		</table>
		<li>
			Province
		</li>
		<table border="1" cellpadding="0" cellspacing="0">
			<tbody>
				<tr>
					<td valign="top" width="307">
						<p align="center">
							<strong>P&eacute;riode</strong>
						</p>
					</td>
					<td valign="top" width="307">
						<p align="center">
							<strong>Montant</strong>
						</p>
					</td>
				</tr>
				<tr>
					<td valign="top" width="307">
						<p>
							<% try{
									int annee = 0;
									annee = lcrdistimpprov[0].getAnnee();
									out.println(annee);
							  }
							  catch(Exception e){
									out.println(0);
							  }%>
						</p>
					</td>
					<td valign="top" width="307">
							<% try{
									String montant = null;
									montant = Utilitaire.formaterAr(lcrdistimpprov[0].getMontantimpaye());
									out.println(montant);
							  }
							  catch(Exception e){
									out.println(0);
							  }%>
					</td>
				</tr>
				<%for(int m=lcdrdistimpmoisprov.length;m>0;m--){%>
				<tr>
				  <td valign="top" width="307">
						<p>
							<% try{
									int mois = 0;
									mois = (lcdrdistimpmoisprov[m-1]!=null)?lcdrdistimpmoisprov[m-1].getMois():0;
									out.println(mois);
							  }
							  catch(Exception e){
									out.println(0);
							  }%>
						</p>
					</td>
					<td valign="top" width="307">
							<% try{
									String montant = null;
									montant =Utilitaire.formaterAr( ((lcdrdistimpmoisprov[m-1]!=null)?lcdrdistimpmoisprov[m-1].getMontantimpaye():0));
									out.println(montant);
							  }
							  catch(Exception e){
									out.println(0);
							  }
							  %>
					</td>
				  </tr>
				  <%}%>
			</tbody>
		</table>
		<%
	}
	if(commercial.compareToIgnoreCase("unchecked") != 0){
		%>
				
		<p>
			<strong>3. </strong>
			<strong><u>Rapport Commercial</u></strong>
		</p>Pub du jour
		<table border="1" cellpadding="0" cellspacing="0">
			<tbody>
				<tr>
					<td valign="top" width="205">
						<p align="center">
							<strong>Gazety</strong>
						</p>
					</td>
					<td valign="top" width="205">
						<p align="center">
							<strong>Montant pub</strong>
						</p>
					</td>
					<td valign="top" width="205">
						<p align="center">
							<strong>Nb pub</strong>
						</p>
					</td>
				</tr>
				<%for(int i=0;i<lcrpub.length;i++){%>
				<tr>
					<td valign="top" width="205">
						<%=lcrpub[i].getJournal()%>
					</td>
					<td valign="top" width="205">
						<%=Utilitaire.formaterAr(lcrpub[i].getMontantpub())%>
					</td>
					<td valign="top" width="205">
						<%=lcrpub[i].getNbrepub()%>
					</td>
				</tr>
				<%}%>
			</tbody>
		</table>
				impay&eacute;:
		<table border="1" cellpadding="0" cellspacing="0">
			<tbody>
				<tr>
					<td valign="top" width="307">
						<p align="center">
							<strong>P&eacute;riode</strong>
						</p>
					</td>
					<td valign="top" width="307">
						<p align="center">
							<strong>Montant</strong>
						</p>
					</td>
				</tr>
				<tr>
					<td valign="top" width="307">
						<p>
							<%=prevYear%>
						</p>
					</td>
					<td valign="top" width="307">
							<%try{
									String montant = null;
									montant =Utilitaire.formaterAr(((lcrcomimpayean[0]!=null)?lcrcomimpayean[0].getMontantimpaye():0));
									out.println(montant);
							  }
							  catch(Exception e){
									out.println(e.getMessage());
							  }
							%>
					</td>
				</tr>
				<%for(int m=lcrcomimpayemois.length;m>0;m--){%>
				<tr>
				  <td valign="top" width="307">
						<p>
							<% try{
									int mois = 0;
									mois = (lcrcomimpayemois[m-1]!=null)?lcrcomimpayemois[m-1].getMois():0;
									out.println(mois);
							  }
							  catch(Exception e){
									out.println(0);
							  }%>
						</p>
					</td>
					<td valign="top" width="307">
							<% try{
									String montant = null;
									montant = Utilitaire.formaterAr(((lcrcomimpayemois[m-1]!=null)?lcrcomimpayemois[m-1].getMontantimpaye():0));
									out.println(montant);
							  }
							  catch(Exception e){
									out.println(0);
							  }
							  %>
					</td>
				  </tr>
				  <%}%>
			</tbody>
		</table>
		<%
	}
  %>
  