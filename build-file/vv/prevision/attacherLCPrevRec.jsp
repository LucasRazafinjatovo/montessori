<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="prevision.*" %>
<%@ page import="bean.*" %>
<%!
    UserEJB u = null;
    String lien=null;
    String acte = null;
%>
<%try
  {
    acte = request.getParameter("acte");
    lien=(String)session.getValue("lien");
    u=(UserEJB)session.getAttribute("u");
    if(acte.compareTo("attacherLC")==0){
      System.out.println("tafiditra ato:"+acte);
    String ret = u.verifLCPrev(request.getParameter("idprev"));
    if(ret.compareTo("ok")==0){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=prevision/ventilationPrevLcRecette.jsp&numObjet=<%=request.getParameter("idPrev")%>");
</script>
<%}} }catch(Exception e){
        e.printStackTrace();%>
        <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<% return;
  }
%>

