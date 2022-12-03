<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  String apres="finance/croiseSortie.jsp";
  String lien= null;
  UserEJB u = null;
  TypeObjet te[] = null;
  TypeObjet dev[] = null;
  facture.Client clt[] = null;
  TypeObjet mp[] =null;
  Caisse caiss[] = null;
  Sortie sortie[] = null;
  Sortie sortiePage[] = null;
  String numPiece=null;
  String numero=null;
  String agence=null;
  String parution=null;
  String designation=null;
  historique.MapUtilisateur ut=null;
  String client, idType,idDepense, caisse, idModePaiement, dateDebut, dateFin, projet, partenaire, facture;
  String colonne,ordre,nomLigne,centre;
  String devise=null;
  int pazy=0;
  int nbParPazy=10;
  int pazy1=0;
  int pazy2=0;
  String nomCol[]=null;
  String listeCentre[]=null;
  double sommeSortie=0;
  ObjetCroise oc=null;
  String apresW=null;
 %>
<%
pazy=Utilitaire.stringToInt(request.getParameter("pazy"));
  u=(UserEJB)session.getValue("u");
     lien=(String)session.getValue("lien");
     te = u.findTypeObjet("TypeSortie","%","%");
     clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
     mp = u.findTypeObjet("Beneficiaire","%","%");
     dev = u.findTypeObjet("Devise","%","%");
     caiss = u.findCaisse("%","%","%","%");
     ut=u.getUser();
%>
<%
  try{
  nomCol=Utilitaire.getNomColonne(new Sortie());
  listeCentre=Utilitaire.getNomColonne(new Sortie(),"nombre");
  //client=request.getParameter("client");if ((client==null)||client.compareTo("")==0) client="%";
  idDepense=request.getParameter("idDepense");if ((idDepense==null)||idDepense.compareTo("")==0) idDepense="%";
  idType=request.getParameter("idType");if ((idType==null)||idType.compareTo("")==0) idType="%";
  caisse=request.getParameter("caisse");if ((caisse==null)||caisse.compareTo("")==0) caisse="%";
  //agence=request.getParameter("agence");if ((agence==null)||agence.compareTo("")==0) agence="%";
  devise=request.getParameter("devise");if ((devise==null)||devise.compareTo("")==0) devise="%";
  designation=request.getParameter("designation");if ((designation==null)||designation.compareTo("")==0) designation="%";
  //numPiece=request.getParameter("numPiece");if ((numPiece==null)||numPiece.compareTo("")==0) numPiece="%";
  numero=request.getParameter("numero");if ((numero==null)||numero.compareTo("")==0) numero="%";
  colonne=request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne=nomCol[0];
  nomLigne=request.getParameter("nomLigne");if ((nomLigne==null)||nomLigne.compareTo("")==0) nomLigne=nomCol[0];
  ordre=request.getParameter("ordre");if ((ordre==null)||ordre.compareTo("")==0) ordre="DESC";
  idModePaiement=request.getParameter("idModePaiement");
  if ((idModePaiement==null)||idModePaiement.compareTo("")==0) idModePaiement="%";
  apresW=request.getParameter("apresW");if ((apresW==null)||apresW.compareTo("")==0) apresW="";
  dateDebut=request.getParameter("dateDebut");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="";
  dateFin=request.getParameter("dateFin");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";
  centre=request.getParameter("centre");if ((centre==null)||centre.compareTo("")==0) centre="";
  projet=request.getParameter("projet");if ((projet==null)||projet.compareTo("")==0) projet="%";
    partenaire=request.getParameter("partenaire");if ((partenaire==null)||partenaire.compareTo("")==0) partenaire="%";
    facture=request.getParameter("facture");if ((facture==null)||facture.compareTo("")==0) facture="%";
  //public Sortie[] findSortieLettre(String idSortie, String daty1, String daty2, String beneficiaire, String typeSortie, String designation, String idModePaiement, String idDevise, String idCaisse, String idEtat, String parution, String agence, String colonne, String ordre, String apresW)
  sortie = u.findSortieLettre(idDepense,dateDebut, dateFin, "%",idType, designation,"%", "%", caisse, "eta2","%","%","montant","DESC",projet, partenaire, facture, apresW);//n'affiche que les sorties crees seulement, n'affiche pas le annulees

  //out.println(apresW+"  DATE DEBUT ="+dateDebut+" << DATE FIN = "+ dateFin+" << Centre = "+centre +" << id Mode Paiement = "+idModePaiement );
  oc=new ObjetCroise(sortie,colonne,nomLigne,centre,"sortielettre");
  //out.println(oc.getSortie());
   //sommeEntree=AdminEntree.getSommeEntree(entree,pazy1,pazy2);
}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Lister les depenses crois&eacute;es </h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les sorties)</p>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="listeDepense" id="listeDepense">
 <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
    <tr>
      <td> <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <tr>
            <td class="left">Date début :</td>
            <td> <input name="datyInf" type="text" class="champ" id="datyInf" value="<%=dateDebut%>" size="10" maxlength="10">
              <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
            <td class="left">Date fin:</td>
            <td> <input name="datySup" type="text" class="champ" id="datySup" value="<%=dateFin%>" size="10">
              <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
          </tr>
          <tr>
            <td class="left">D&eacute;signation :</td>
            <td> <input name="designation" type="text" class="champ" id="designation" <%=designation%>></td>
            <td class="left">Projet :</td>
            <td> <input name="projet" type="text" class="champ" id="projet" size="10"></td>
          </tr>
          <tr>
            <td class="left">Caisse :</td>
            <td ><select name="caisse" class="champ">
                <option value="%">Tous</option>
                <%
          for(int i=0;i<caiss.length;i++){
          %>
                <option value=<%=caiss[i].getIdCaisse()%> <%if(caiss[i].getIdCaisse().compareTo(caisse)==0)out.print("selected");%>><%=caiss[i].getDescCaisse()%></option>
                <%
                }
                %>
              </select></td>
            <td class="left">Facture : </td>
            <td> <input name="facture" type="text" class="champ" id="facture" size="10"> </td>
          </tr>
          <tr>
            <td class="left">Partenaire :</td>
            <td align="center"> <div align="left">
                <input name="partenaire" type="text" class="champ" id="partenaire" value="%">
                &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
              </div></td>
            <td class="left">Numéro :</td>
            <td align="center"> <div align="left">
                <input name="idDepense" type="text" class="champ" id="idDepense" value=<%=idDepense%>>
                &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
              </div></td>
          </tr>
          <tr>
            <td class="left">Type : </td>
            <td><select name="idType" class="champ" id="idType">
                <option value="%">Tous</option>
                <%
          for(int i=0;i<te.length;i++){
          %>
                <option value="<%=te[i].getId()%>"><%=te[i].getVal()%></option>
                <%
                }
                %>
              </select> </td>
            <td class="left">Bénéficiaire :</td>
            <td align="center"> <select name="idModePaiement" class="champ" id="idModePaiement">
                <option value="%">Tous</option>
                <%
   for(int i=0;i<mp.length;i++){
 %>
                <option value=<%=mp[i].getTuppleID()%> <%if(mp[i].getTuppleID().compareTo(idModePaiement)==0)out.print("selected");%>><%=mp[i].getVal()%></option>
                <%
   }
 %>
              </select> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>

        </table></td>
    </tr>
   <tr>
     <td height="30" align="center"><strong><font color="#FF0000" size="+1">CROISER
       PAR </font></strong></td>
   </tr>
   <tr>
     <td height="30" align="center"><table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
         <tr>
           <td class="left">Col :</td>
           <td align="center"><select name="colonne"   id="select4">
               <%
  for(int i=0;i<nomCol.length;i++){
%>
               <option value="<%=nomCol[i]%>"<%if (nomCol[i].compareTo("source")==0) out.println("selected");%>><%=nomCol[i]%></option>
               <%
  }
%>
             </select>
             &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </td>
           <td class="left"><div align="center">Ligne :</div></td>
           <td align="center"><select name="nomLigne"   id="select2">
               <%
  for(int i=0;i<nomCol.length;i++){
%>
               <option value="<%=nomCol[i]%>"<%if (nomCol[i].compareTo("idTypeEntree")==0) out.println("selected");%>><%=nomCol[i]%></option>
               <%
  }
%>
             </select>
             &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> </td>
           <td align="center"><strong>Centre: </strong></td>
           <td align="center"><select name="centre"   id="select">
               <%
  for(int i=0;i<listeCentre.length;i++){
%>
               <option value="<%=listeCentre[i]%>"><%=listeCentre[i]%></option>
               <%
  }
%>
           </select></td>
         </tr>
     </table></td>
   </tr>

    <tr>
      <td height="30" align="center"> <table width="75%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center"> <input type="submit" name="Submit" value="Afficher" class="submit">
            </td>
            <td align="center"> <input type="reset" name="annuler" value="Annuler" class="submit">
            </td>
          </tr>
        </table></td>
    </tr>
  </table>
</form>

                <TABLE border=1>
<TR><TD></TD>
<%for (int i=0;i<oc.getValCol().length;i++){ // liste des valeurs de la colonne
  if (oc.getSommeColonne()[i]>0){
%>
  <TD><%=oc.getValCol()[i]%></TD>
                <%}}%>
                <TD></TD>
                </TR>
                <%for (int j=0;j<oc.getValLigne().length;j++){//liste ligne
                  if (oc.getSommeLigne()[j]>0)
                  {
%>
                  <TR>
                  <TD><%=oc.getValLigne()[j]%></TD>
                <%for (int k=0; k<oc.getValCol().length;k++){ //affichage
                  if (oc.getSommeColonne()[k]>0){
                    apresW=colonne+"%3D%27"+oc.getValCol()[k]+"%27 and "+nomLigne+"%3D%27"+oc.getValLigne()[j]+"%27";
%>
                  <TD align="right"><a href="<%=lien%>?but=finance/listeSortieCroise.jsp&pazy=<%=pazy%>&caisse=<%=Utilitaire.remplacePourcentage(caisse)%>&idModePaiement=<%=Utilitaire.remplacePourcentage(idModePaiement)%>&dateDebut=<%=dateDebut%>&dateFin=<%=dateFin%>&colonne=montant&ordre=DESC&apresW=<%=apresW%>"><%=Utilitaire.formaterAr(oc.getCroise()[j][k])%></a></TD>
<%}}%>
<TD align="right"><B><%=Utilitaire.formaterAr(oc.getSommeLigne()[j])%></B></TD>
</TR>

                  <%}}%>
<TR><TD></TD>
<%for (int h=0;h<oc.getValCol().length;h++){
  if (oc.getSommeColonne()[h]>0){
%>
  <TD align="right"><B><%=Utilitaire.formaterAr(oc.getSommeColonne()[h])%></B></TD>
                <%}}%>
                <TD align="right"><B><%=Utilitaire.formaterAr(oc.getSommeTotal())%></B></TD>
                </TR>
                </TABLE>
<br>

<script language="javascript">
  var cal1 = new calendar1(document.forms['listeDepense'].elements['datyInf']);
  cal1.year_scroll = false;
  cal1.time_comp = false;
  var cal2 = new calendar1(document.forms['listeDepense'].elements['datySup']);
  cal2.year_scroll = false;
  cal2.time_comp = false;
</script>
