<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="finance.*" %>
<%@ page import="facturefournisseur.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facturefournisseur/listeFournisseur.jsp";
        String lien= null;
        UserEJB u = null;
        Caisse caiss[] = null;
		String etatCaisse=null;
		historique.MapUtilisateur ut=null;
		facturefournisseur.Fournisseur frns[]=null;
		String fournisseur="";
		String nif="";
		String stat="";
		String tel="";
		String email="";
		String adresse="";
		String apresW="";

%>
<%
try{
u=(UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
caiss = u.findCaisse("%","%","%","%");
 ut=u.getUser();
 
 fournisseur=request.getParameter("fournisseur");if ((fournisseur==null)||fournisseur.compareTo("")==0) fournisseur="%";
  nif=request.getParameter("nif");if ((nif==null)||nif.compareTo("")==0) nif="%";
   stat=request.getParameter("stat");if ((stat==null)||stat.compareTo("")==0) stat="%";
      tel=request.getParameter("tel");if ((tel==null)||tel.compareTo("")==0) tel="%";
	  email=request.getParameter("email");if ((email==null)||email.compareTo("")==0) email="%";
	 adresse=request.getParameter("adresse");if ((adresse==null)||adresse.compareTo("")==0) adresse="%";
	  apresW=request.getParameter("apresW");if ((apresW==null)||apresW.compareTo("")==0) apresW="";
 out.println(fournisseur+" "+ nif+" "+stat+" "+tel+" "+email+" "+adresse+" "+apresW);
 frns= u.findFournisseurF("%", fournisseur,  nif,  stat,  tel,  email, adresse,  apresW);
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Liste des fournisseurs</h1>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="listeFournisseur" id="listeFournisseur">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
         
          <tr> 
            <td class="left">Fournisseur :</td>
            <td align="center"><input name="fournisseur" type="text"   id="fournisseur" value="<%=fournisseur%>"size="10" maxlength="10" /> &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> 
            </td>
            
    <td class="left">N.I.F</td>
            <td align="center"><input name="nif" type="text"   id="nif" value="<%=nif%>"size="10" maxlength="10" /> 
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> 
            </td>
          </tr>
          
		  <tr> 
            
    <td class="left">Stat :</td>
            <td align="center"><input name="stat" type="text"   id="stat" value="<%=stat%>" /> 
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> 
            </td>
            
    <td class="left">Tel</td>
            <td align="center"><input name="tel" type="text"   id="tel" value="<%=tel%>" /> </td>
          </tr>
		  
		  <tr> 
            
    <td class="left">Email :</td>
            <td align="center"><input name="email" type="text"   id="email" value="<%=email%>" /> 
              &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle" /> 
            </td>
            
    <td class="left">Adresse</td>
            <td align="center"><input name="adresse" type="text"   id="adresse" value="<%=adresse%>" /> </td>
          </tr>
		  
		  
        </table>

<input type="submit" value="rechercher">

</form>
<table width="103%" border="0" class="monographe">
  <tr> 
    <td width="34%"><strong>Fournisseur</strong></td>
    <td width="8%"><strong>N.I.F</strong></td>
    <td width="8%"><strong>Stat</strong></td>
    <td width="8%"><strong>Tel</strong></td>
    <td width="20%"><strong>Email</strong></td>
    <td width="22%"><strong>Adresse</strong></td>
  </tr>
  <%
  for(int i=0;i<frns.length;i++){
  %>
  <tr> 
    <td><%=frns[i].getnomFournisseur()%></td>
    <td><%=frns[i].getnifFournisseur()%></td>
    <td><%=frns[i].getstatFournisseur()%></td>
    <td><%=frns[i].gettelFournisseur()%></td>
    <td><%=frns[i].getemailFournisseur()%></td>
    <td><%=frns[i].getadresseFournisseur()%></td>
  </tr>
  <%
  }
  %>
</table>
