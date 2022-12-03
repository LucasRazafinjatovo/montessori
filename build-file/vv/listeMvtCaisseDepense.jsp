<html>
<head>
<title>
listeMvtCaisseDepense
</title>
</head>
<jsp:useBean id="listeMvtCaisseDepenseBeanId" scope="session" class="finance.listeMvtCaisseDepenseBean" />
<jsp:setProperty name="listeMvtCaisseDepenseBeanId" property="*" />
<body>
<h1>
JBuilder Generated JSP
</h1>
<form method="post">
<br>Enter new value   :  <input name="sample"><br>
<br><br>
<input type="submit" name="Submit" value="Submit">
<input type="reset" value="Reset">
<br>
Value of Bean property is :<jsp:getProperty name="listeMvtCaisseDepenseBeanId" property="sample" />
</form>
</body>
</html>
