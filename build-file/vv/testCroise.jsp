<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="finance.Entree" %>
<%@ page import="bean.ObjetCroise" %>
<%!
  UserEJB u=null;
  String username=null;
  String pwd=null;
  historique.MapUtilisateur ut=null;
  String lien;
%>

<%
  try
{
  username=request.getParameter("identifiant");
  pwd=request.getParameter("passe");
  UserEJBClient uc=new UserEJBClient();
  u=uc.getInterface();
  u.testLogin("dg","dgxdg");
  session.putValue("u", u);
  ut=u.getUser();
  Entree[] e=u.findEntreeLettre("%", "11/01/2007", "21/01/2007", "%", "%","%","%","%","%", "%","%","%","%","idEntree","ASC");
                ObjetCroise oc=new ObjetCroise(e,"idTypeEntree","source","montant","entreeLettre");%>
                <TABLE border=1>
<TR><TD></TD>
<%for (int i=0;i<oc.getValCol().length;i++){
  if (oc.getSommeColonne()[i]>0){
%>
  <TD><%=oc.getValCol()[i]%></TD>
                <%}}%>
                <TD></TD>
                </TR>
                <%for (int j=0;j<oc.getValLigne().length;j++){
                  if (oc.getSommeLigne()[j]>0)
                  {
%>
                  <TR>
                  <TD><%=oc.getValLigne()[j]%></TD>
                <%for (int k=0; k<oc.getValCol().length;k++){
                  if (oc.getSommeColonne()[k]>0){
%>
                  <TD><%=Utilitaire.formaterAr(oc.getCroise()[j][k])%></TD>
<%}}%>
<TD><B><%=Utilitaire.formaterAr(oc.getSommeLigne()[j])%></B></TD>
</TR>

                  <%}}%>
<TR><TD></TD>
<%for (int h=0;h<oc.getValCol().length;h++){
  if (oc.getSommeColonne()[h]>0){
%>
  <TD><B><%=Utilitaire.formaterAr(oc.getSommeColonne()[h])%></B></TD>
                <%}}%>
                <TD><B><%=Utilitaire.formaterAr(oc.getSommeTotal())%></B></TD>
                </TR>
                </TABLE>
                  <% out.println(e.length);

                    }catch (Exception e){

                      e.printStackTrace();
                      %>
                  <script language="JavaScript">
                    alert("Login ou mot de passe erroné");
                  </script>
                  <%
                    return;
                    }
        %>



