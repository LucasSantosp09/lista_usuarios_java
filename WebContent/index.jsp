<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="config.Conexao" %>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="css/estilologin.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css">
<!------ Include the above in your HEAD tag ---------->
<%
	Statement st = null;
	ResultSet rs = null;
%>

<body>
	<div id="login">

		<div class="container">
			<div id="login-row"
				class="row justify-content-center align-items-center">
				<div id="login-column" class="col-md-6">
					<div id="login-box" class="col-md-12">
						<form id="login-form" class="form" action=""
							method="post">
							<h3 class="text-center text-info">Login</h3>
							<div class="form-group">
								<label for="username" class="text-info">Usuário:</label><br>
								<input type="text" name="txtusuario" id="txtusuario"
									class="form-control">
							</div>
							<div class="form-group">
								<label for="password" class="text-info">Senha:</label><br>
								<input type="password" name="txtsenha" id="txtsenha"
									class="form-control">
							</div>
							<div class="form-group">
								<label for="remember-me" class="text-info"><span>Lembra-me</span> <span><input
										id="remember-me" name="remember-me" type="checkbox"></span></label><br>
								<input type="submit" name="submit" class="btn btn-info btn-md"
									value="Entrar">
							</div>
							<div id="register-link" class="text-right">
								<a href="#" class="text-info">Cadastra-se</a>
							</div>
						</form>
					</div>
				</div>
			</div>
			<p align="center" class="text-light mt-2">
				<%
					String usuario = request.getParameter("txtusuario");
					String senha = request.getParameter("txtsenha");
					String nomeUsuario = "";				
					String user = "", pass = ""; 	
					int i = 0 ;

					try {
		
						st = new Conexao().conectar().createStatement();
						rs = st.executeQuery("SELECT * FROM usuarios where usuario = '"+usuario+"' and senha = '"+senha+"'");
						while (rs.next()) {
						user = rs.getString(3);
						pass = rs.getString(4);
						nomeUsuario = rs.getString(2);
						rs.last();
						i = rs.getRow();						
						}
						
					

					} catch (Exception e) {
							out.println(e);
					}

					if (usuario == null || senha == null) {
						out.println("Preencha o campo usuário e senha");
					} else {
						if (usuario.equals(user) && senha.equals(pass)) {
							session.setAttribute("nomeUsuario", nomeUsuario);
							response.sendRedirect("usuarios.jsp");
					
						} else {
							out.println("Usuário ou senha inválidos");
						}
					}
				%>
			</p>
		</div>
	</div>
</body>
