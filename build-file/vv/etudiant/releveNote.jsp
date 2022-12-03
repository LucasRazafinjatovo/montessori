<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="etudiant.*" %>
<%@ page import="promotion.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="examen.*" %>
<%
String id=request.getParameter("id");
UserEJB u=null;
Etudiant et=new Etudiant();
et.setId(id);
Etudiant[]listeEt=(Etudiant[])CGenUtil.rechercher(et,null,null,"");
NoteComplet note=new NoteComplet();
note.setEtudiant(id);

  try{

    u=(user.UserEJB)session.getValue("u");
  lien=(String)session.getValue("lien");

  }catch(Exception e){
   %>
  <script language="JavaScript"> document.location.replace("../erreur.jsp?message=<%=e.getMessage()%>"); </script>
  <%
  }
%>
<link href="style.css" rel="stylesheet" type="text/css">
<title>RELEVE DE NOTES</title>
ITUniversity
<tr>
    <td>Nom : </td>
    <td><%=listeEt[0].getNom()%></td>
 </tr>

