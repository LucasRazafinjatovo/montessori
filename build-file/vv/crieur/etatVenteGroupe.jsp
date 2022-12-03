<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="crieur.*" %>
<%@ page import="pub.*" %>
<%@ page import="lc.Direction" %>
<%!
	Etatventecrieur p;
	%>
	<%
	p=new Etatventecrieur();
	String etat="Etatventecrieur";
	if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
		etat=request.getParameter("etat");
	p.setNomTable(etat);
	String listeCrt[]={"grossiste","vendeur","matricule","journal","place","province","type","numParution","daty","titre","jour","heure","rubrique"};
	String listeInt[]={"daty","numParution"};

	String colDefaut[]={"journal","numParution","titre","jour","heure","rubrique"};
	String somDefaut[]={"nbrePrise","vente","totalcommission","montant","recette"};
	PageRechercheGroupe pr=new PageRechercheGroupe(p,request,listeCrt,listeInt,3,colDefaut,somDefaut,7,5);
	
	pr.setUtilisateur((user.UserEJB)session.getValue("u"));
	pr.setLien((String)session.getValue("lien"));
	pr.setApres("crieur/etatVenteGroupe.jsp");
	affichage.Champ[] liste=new affichage.Champ[4];
	
	
	Vendeur ve=new Vendeur();
	ve.setNomTable("crieur");
	liste[0]=new Liste("Vendeur",ve,"surnom","surnom");
	
	TypeObjet j=new TypeObjet();
	j.setNomTable("jour");
	liste[1]=new Liste("jour",j,"val","val");
	
	Rubrique r=new Rubrique();
	r.setNomTable("rubrique");
	liste[2]=new Liste("rubrique",r,"libelle","libelle");
	
	Vendeur gr=new Vendeur();
	gr.setNomTable("grossiste");
	liste[3]=new Liste("grossiste",gr,"surnom","surnom");
	
	pr.getFormu().changerEnChamp(liste);
	pr.getFormu().getChamp("grossiste").setAutre("onchange='checkVendeur(this)'");
	pr.setNpp(100);
	pr.creerObjetPage();
	%>
	<h1>Etat de vente journal groupe</h1>
	<form action="<%=pr.getLien()%>?but=crieur/etatVenteGroupe.jsp" method="post" name="listePub" id="listePub">
		<%
		out.println(pr.getFormu().getHtmlEnsemble());%>
		etat : <select name="etat" class="champ" id="etat" >
				<option value="Etatventecrieur">Tous</option>
				<option value="etatVentePaye"  <%if(etat.compareTo("fcorgroupepaye")==0) out.println("selected");%>>paye</option>
				<option value="etatVenteImpaye"  <%if(etat.compareTo("fcorgroupeImpaye")==0) out.println("selected");%>>impaye</option>
		</select>
	</form>
	<%
		out.println(pr.getTableauRecap().getHtml());
	%>
	<br>
	<%
		out.println(pr.getTableau().getHtml());
		out.println(pr.getBasPage());
	%>
