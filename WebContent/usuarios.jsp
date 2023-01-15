<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="config.Conexao"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String pag = "usuarios.jsp";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css">
<link href="css/estilos.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
	integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous"></script>
<title>Lista de Usuários</title>
</head>
<body>
	<%
		Statement st = null;
		ResultSet rs = null;
	%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="usuarios.jsp">Lista de Usuários</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
		
			<ul class="navbar-nav mr-auto">

				

				
			</ul>
		
			<form class="form-inline my-2 my-lg-0">
				<span><small> <%
 	String nomeUsuario = (String) session.getAttribute("nomeUsuario");
 	out.print(nomeUsuario);
 	if (nomeUsuario == null) {
 		response.sendRedirect("index.jsp");
 	}
 %></span></small> <a href="logout.jsp"><i class="fas fa-sign-out-alt ml-2"></i></a>
			</form>
		</div>
	</nav>
	<div class="container">
		<div class="row mt-4 mb-4">
			<button class="btn-info btn-sm" data-toggle="modal"
				data-target="#modal">Novo Usuário</button>
			<form class="form-inline my-2 my-lg-0 direita">
				<input class="form-control form-control-sm mr-sm-2" type="search"
					name="txtbuscar" placeholder="Buscar pelo nome" aria-label="Search">
				<button class="btn btn-outline-info btn-sm my-2 my-sm-0"
					type="submit" name="btn-buscar">Buscar</button>
			</form>
		</div>
		<table class="table table-striped table-sm table-dark">
			<thead>
				<tr>
					<th scope="col">Nome</th>
					<th scope="col">Usuário</th>
					<th scope="col">Senha</th>
					<th scope="col">Nível</th>
				</tr>
			</thead>
			<tbody>
				<%
					try {

						st = new Conexao().conectar().createStatement();
						if (request.getParameter("btn-buscar") != null) {
							String buscar = '%' + request.getParameter("txtbuscar") + '%';
							rs = st.executeQuery("SELECT * FROM usuarios where nome LIKE '" + buscar + "' order by nome asc");
						} else {
							rs = st.executeQuery("SELECT * FROM usuarios order by nome asc");
						}

						while (rs.next()) {
				%>

				<tr>
					<td><%=rs.getString(2)%></td>
					<td><%=rs.getString(3)%></td>
					<td><%=rs.getString(4)%></td>
					<td><%=rs.getString(5)%></td>
					<td><a href="<%=pag%>?funcao=editar&id=<%=rs.getString(1)%>"
						class="text-info"><i class="far fa-edit"></i></a> <a
						href="<%=pag%>?funcao=excluir&id=<%=rs.getString(1)%>"
						class="text-danger"><i class="far fa-trash-alt"></i></a></td>
				</tr>


				<%
					}
					} catch (Exception e) {
						out.print(e);
					}
				%>
			</tbody>
		</table>
	</div>

</body>
</html>



<!-- Modal -->
<div class="modal fade" id="modal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<%
					String titulo = "";
					String btn = "";
					String xid = "";
					String xnome = "";
					String xusuario = "";
					String xsenha = "";
					String xnivel = "Selecione um Nível";
					if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("editar")) {
						titulo = "Editar Usuário";
						btn = "btn-editar";
						xid = request.getParameter("id");
						try {
							st = new Conexao().conectar().createStatement();
							rs = st.executeQuery("SELECT * FROM usuarios where id = '" + xid + "' ");
							while (rs.next()) {
								xnome = rs.getString(2);
								xusuario = rs.getString(3);
								xsenha = rs.getString(4);
								xnivel = rs.getString(5);

							}
						} catch (Exception e) {
							out.print(e);
						}
					} else {
						titulo = "Inserir Usuário";
						btn = "btn-salvar";
					}
				%>
				<h5 class="modal-title" id="exampleModalLabel" class="text-info">Inserir
					Usuário</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form id="cadastro-form" class="form" action="" method="post">
				<div class="modal-body">

					<input value="<%=xusuario%>" type="hidden" name="txtantigo"
						id="txtantigo">

					<div class="form-group">
						<label for="username">Nome</label><br> <input
							value="<%=xnome%>" type="text" name="txtnome" id="txtnome"
							class="form-control" required>
					</div>

					<div class="form-group">
						<label for="username">Usuário</label><br> <input
							value="<%=xusuario%>" type="text" name="txtusuario"
							id="txtusuario" class="form-control" required>
					</div>
					<div class="form-group">
						<label for="password">Senha</label><br> <input
							value="<%=xsenha%>" type="text" name="txtsenha" id="txtsenha"
							class="form-control" required>
					</div>

					<div class="form-group">
						<label for="exampleFormControlSelect2">Nível</label> <select
							class="form-control" name="txtnivel" id="txtnivel" required>
							<option value="<%=xnivel%>"><%=xnivel%></option>
							<%
								if (!xnivel.equals("Comum")) {
									out.print(" <option>Comum</option>");
								}
								if (!xnivel.equals("Admin")) {
									out.print(" <option>Admin</option>");
								}
							%>



						</select>
					</div>



				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Fechar</button>
					<button type="submit" name="<%=btn%>" class="btn btn-primary"><%=titulo%></button>
				</div>
			</form>
		</div>
	</div>
</div>


<%
	if (request.getParameter("btn-salvar") != null) {
		String usuario = request.getParameter("txtusuario");
		String senha = request.getParameter("txtsenha");
		String nivel = request.getParameter("txtnivel");
		String nome = request.getParameter("txtnome");

		try {

			st = new Conexao().conectar().createStatement();
			rs = st.executeQuery("SELECT * FROM usuarios where usuario = '" + usuario + "'");

			while (rs.next()) {
				rs.getRow();
				if (rs.getRow() > 0) {
					out.print("<script>alert('Usuário Já Cadastrado!');</script>");
					return;
				}
			}
			st.executeUpdate("INSERT into usuarios (nome, usuario, senha, nivel) values ('" + nome + "', '"
					+ usuario + "', '" + senha + "', '" + nivel + "')");
			response.sendRedirect("usuarios.jsp");
		} catch (Exception e) {
			out.print(e);
		}
	}
%>

<%
	if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("excluir")) {
		String id = request.getParameter("id");
		try {

			st = new Conexao().conectar().createStatement();
			st.executeUpdate("DELETE from usuarios where id = '" + id + "'");

			response.sendRedirect(pag);
		} catch (Exception e) {
			out.print(e);
		}
	}
%>

<%
	if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("editar")) {
		out.print("<script>$('#modal').modal('show');</script>");
	}
%>

<%
	if (request.getParameter("btn-editar") != null) {
		String usuario = request.getParameter("txtusuario");
		String senha = request.getParameter("txtsenha");
		String nivel = request.getParameter("txtnivel");
		String nome = request.getParameter("txtnome");
		String id = request.getParameter("id");
		String antigo = request.getParameter("txtantigo");

		try {

			st = new Conexao().conectar().createStatement();
			if (!antigo.equals(usuario)) {
				rs = st.executeQuery("SELECT * FROM usuarios where usuario = '" + usuario + "'");
				while (rs.next()) {
					rs.getRow();
					if (rs.getRow() > 0) {
						out.print("<script>alert('Usuário Já Cadastrado!');</script>");
						return;
					}
				}
			}
			st.executeUpdate("UPDATE usuarios SET nome = '" + nome + "', usuario = '" + usuario + "', senha = '"
					+ senha + "', nivel = '" + nivel + "' where id = '" + id + "'");
			response.sendRedirect(pag);
		} catch (Exception e) {
			out.print(e);
		}
	}
%>

