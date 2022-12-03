<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="lc.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
        UserEJB u = null;
        String acte=null;
        String id=null;
        String lien=null;
        historique.MapUtilisateur ut = null;
        String username=null;
        String pwd=null;
        String designation =null;
%>
<%
try
{
  username="lalanirina";
  pwd="ambinintsoa";
  UserEJBClient uc=new UserEJBClient();
  u=uc.getInterface();
  u.testLogin(username,pwd);
  session.setAttribute("u", u);
  ut=u.getUser();
  Direction crd=new Direction();
  crd.setIdDir(ut.getAdruser());
  Direction[] ret=(Direction[])(CGenUtil.rechercher(crd,null,null,""));
  designation = request.getParameter("designation");
  String lcstring = request.getParameter("lcstring");

  String montant = request.getParameter("montant");
  String fournisseur = request.getParameter("fournisseur");



  if(ret.length>0)
  {
	session.setAttribute("dirlib",ret[0].getLibelledir());
	u.setIdDirection(ret[0].getLibelledir());
  }
  if(ut.getIdrole().compareTo("dg")==0)
  {
	lien="modeleAdmin.jsp";
	session.setAttribute("lien", lien);
	session.setAttribute("dir",ut.getAdruser());
//      out.println("<script language='JavaScript'> document.location.replace('../"+lien+"?but=stock/factureFournisseur.jsp&id="+id+"&montant="+montant+"&fournisseur="+fournisseur+"&designation="+designation+"&id="+request.getParameter("id")+"'); </script>");
        out.println("<script language='JavaScript'> document.location.replace('../"+lien+"?but=stock/factureFournisseur.jsp&id="+id+"&montant="+montant+"&fournisseur="+fournisseur+"&designation="+designation+"&id="+request.getParameter("id")+"&lcstring="+request.getParameter("lcstring")+"'); </script>");
  }
}catch (Exception e){
 %>

<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
		<%
		return;
		}
		%>


<head>
<title>Document sans titre</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<table width="425" border="0" cellspacing="0">
  <tr>
    <td><div align="justify"></div>
    </td>
  </tr>
</table>
</body>
</html>




