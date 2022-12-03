<%@ page import="user.*" %>
<%@ page import="pointage.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!

        String apres="pointage/apresPointage.jsp";
        String lien= null;
		TypeObjet[] source=null;
        String heureInf = null;
         String heureSup = null;
        String datyinf = null;
         String datySup = null,direction=null,entite=null;
          String idPointage = null;
          String datyDefaut=null;
          String nom = null;
          String type = null;
        String agence = null;
        String machine = null;
        String ip = null;
        UserEJB u = null;
        pointage.Tache[] fm=null;
        int pazy=0;
	int nbParPazy=Parametre.getNbParPage();
	lc.Direction dir[] = null;
        historique.MapUtilisateur[] sub=null;

%>
<%
try{
	TypeObjet crt=new TypeObjet();

        u=(user.UserEJB)session.getValue("u");
        lien=(String)session.getValue("lien");
        datyDefaut=request.getParameter("daty");if((datyDefaut==null)||(datyDefaut.compareTo("")==0)) datyDefaut=Utilitaire.dateDuJour();
        crt.setNomTable("Beneficiaire");
dir = u.findDirection("","","","","");
sub=u.findUserSubordonnee();
source=(TypeObjet[])CGenUtil.rechercher(crt,null,null," order by val asc");
//findPointage(String idPointage, String user, String datyInf, String DateSup, String heureInf, String heureSup, String type, String rem, String ip, String agence, String machine) throws Exception, RemoteException;
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
	<link href="../style/style.css" rel="stylesheet" type="text/css">
	  <br>
	  <div align="center">&nbsp;<span class="ajouttitre">Achevement T&acirc;ches</span><br>
  <br>
</div>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="tache">
 <input name="estTache" type="hidden" size="20" maxlength="50" value="effTache">
 <input name="idTache" type="hidden" size="20" maxlength="50" value="<%=request.getParameter("idTache")%>">
<table width="400" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><table border="0" cellpadding="3" cellspacing="0" align="center" class="monographe">
          <!--DWLayoutTable-->
<tr>
  <td width="158" height="23" class="left">Taux d'achevement %</td>
  <td width="226" align="center" valign="top"><input name="daty" type="text" class="champ" id="daty" ></td>
</tr>
        <tr>
          <td height="23" valign="top" class="left">commentaire :</td>
            <td align="center" valign="top">&nbsp;
              <textarea name="remarque" cols="20" rows="5"></textarea>
            </td>
        </tr>
      </table></td>
  </tr>
  <tr>
      <td height="30" align="center">
        <table width="75%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center">
<input type="submit" name="Submit" value="Valider" class="submit">
          </td>
          <td align="center">
<input type="reset" name="Submit2" value="Restaurer" class="submit">
          </td>
        </tr>
      </table>
      </td>
  </tr>
</table>
</form>
<br>
<table width="400" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
    <td> <span class="remarque">** Cette identification est obligatoire avant
      d'utiliser ce système. </span><br>
      <span class="succes">- Entrez votre identifiant et mot de passe. <br>
      - S'il y a un problème, verifiez d'abord votre saisie, sinon contactez votre
      administrateur.</span></td>
</tr>
</table>































