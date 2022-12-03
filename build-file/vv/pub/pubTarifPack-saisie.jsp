<%-- 
    Document   : pubTarifPack-saisie.jsp
    Created on : 12 juil. 2017, 10:34:47
    Author     : Alain
--%>
<%@page import="pub.PubType"%>
<%@page import="pub.TarifRadioPartenariat"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="actualite.*" %>
<%
    TarifRadioPartenariat pj = new TarifRadioPartenariat();
    PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    affichage.Champ[] liste = new affichage.Champ[3];
    
    TypeObjet to2 = new TypeObjet();
    to2.setNomTable("plageradio");
    liste[0]=new Liste("plage",to2,"val","val");
    
    TypeObjet to1 = new TypeObjet();
    to1.setNomTable("natureradio");
    liste[1]=new Liste("libelle",to1,"val","val"); 
    
    TypeObjet to = new TypeObjet();
    to.setNomTable("confpresse");
    liste[2]=new Liste("confpresse",to,"val","val"); 
    
    pi.getFormu().changerEnChamp(liste);
    /*
    id, confpresse, libelle, duree, plage;
    private double montant;
    private int nbspot, nbemission, tophoraire, siconcert;  
    */
    
    pi.getFormu().getChamp("duree").setDefaut("30");
    pi.getFormu().getChamp("nbspot").setDefaut("0");
    pi.getFormu().getChamp("nbemission").setDefaut("0");
    pi.getFormu().getChamp("tophoraire").setDefaut("0");
    pi.getFormu().getChamp("siconcert").setDefaut("0");
    pi.getFormu().getChamp("plage").setLibelle("Plage horaire");
    pi.getFormu().getChamp("duree").setLibelle("Dur&eacute;e");
    pi.getFormu().getChamp("montant").setLibelle("Montant");
    pi.getFormu().getChamp("nbspot").setLibelle("Spot 30s");
    pi.getFormu().getChamp("nbemission").setLibelle("Intervention emission 10mn");
    pi.getFormu().getChamp("tophoraire").setLibelle("TOP HORAIRE");
    pi.getFormu().getChamp("siconcert").setLibelle("Si concert/Matraquage");

    
    pi.preparerDataFormu();
%>

<h1>Saisir Pub Tarif</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="actualite" id="actualite">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="pub/pubTarif-saisie.jsp">
    <input name="classe" type="hidden" id="classe" value="pub.PubTarif">
</form>
