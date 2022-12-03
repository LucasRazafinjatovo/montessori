<%@page import="etudiant.EntiteBeneficiaire"%>
<%@page import="recette.RubriquePrixEntite"%>
<%@page import="etudiant.AnalysePaiement"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="crieur.*" %>
<%@ page import="pub.*" %>
<%@ page import="lc.Direction" %>

<%
    AnalysePaiement analysePaiement = new AnalysePaiement();
    
    String listeCrt[] = {"annee", "idetudiant", "ecole", "echeance","moisint"};
    String listeInt[] = {"echeance", "annee","moisint"};

    String colDefaut[] = {"idetudiant", "nom", "prenom", "echeance", "mois", "annee", "ecole"};
    String somDefaut[] = {"fooddu", "foodpaye", "ecolagedu", "ecolagepaye", "transportdu", "transportpaye", "inscriptiondu", "inscriptionpaye", "autredu", "autrepaye", "montantdu", "montantpaye", "reste"};
    
    PageRechercheGroupe pr = new PageRechercheGroupe(analysePaiement,request,listeCrt,listeInt,3,colDefaut,somDefaut,5,2);

    pr.setUtilisateur((user.UserEJB)session.getValue("u"));
    pr.setLien((String)session.getValue("lien"));
    pr.setApres("etudiant/Analyse-paiement.jsp");
    
    
    pr.getFormu().getChamp("echeance1").setLibelle("Echeance (min)");
    pr.getFormu().getChamp("echeance2").setLibelle("Echeance (max)");
    
    pr.getFormu().getChamp("annee1").setLibelle("Ann�e (min)");
    pr.getFormu().getChamp("annee2").setLibelle("Ann�e (max)");
    
    
    
  
    affichage.Champ[] liste=new affichage.Champ[3];
    EntiteBeneficiaire entite = new EntiteBeneficiaire();
    String idSociete = "SOC00003";
    entite.setIdSociete(idSociete);
    liste[0] = new Liste("ecole", entite, "val", "val");
    String mois[]  = { "Tous" ,"January","February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
    String moisvalue[]  = {"" , "1","2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"};
    liste[1] = new Liste("moisint1", mois, moisvalue);
    
    String mois1[]  = { "Tous" ,"January","February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
    String moisvalue1[]  = {"" , "1","2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"};
    liste[2] = new Liste("moisint2", mois1, moisvalue1);
    
    pr.getFormu().getChamp("moisint1").setLibelle("mois (min)");
    pr.getFormu().getChamp("moisint2").setLibelle("mois (max)");
    pr.getFormu().changerEnChamp(liste);

    //pr.getFormu().getChamp("date_derniere_payement1").setLibelle("Date derni�re payement (min)");
    //pr.getFormu().getChamp("date_derniere_payement2").setLibelle("Date derni�re payement (max)");
    pr.getFormu().getChamp("ecole").setLibelle("Ecole");
    
    pr.setNpp(100);
    pr.creerObjetPage();
    %>
    <h1>Etat paiement</h1>
    <form action="<%=pr.getLien()%>?but=etudiant/Analyse-paiement.jsp" method="post" name="listePub" id="listePub">
        <%
            out.println(pr.getFormu().getHtmlEnsemble());
        %>
            
    </form>
<%
    out.println(pr.getTableauRecap().getHtml());
%>
<br>
<%
    out.println(pr.getTableau().getHtml());
    out.println(pr.getBasPage());
%>
