<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

	<!-- Titulo da pgina -->
	<div class="table-responsive-lg pb-5 containerForm">
		<c:choose>
			<c:when test="${empty dados.LISTA}">
				<p>Não foi possível encontrar nenhum registro!</p>
			</c:when>
			<c:otherwise>
				<table class="table">
		          <thead>
		            <tr>
		              <th scope="col">Id</th>
		              <th scope="col">Aparelho</th>
		              <th scope="col">Tipo Operação</th>
		              <th scope="col">Pessoa</th>
		              <th scope="col">Tipo Pessoa</th>
		              <th scope="col">Ações</th>
		            </tr>
		          </thead>
		          <tbody>
		          	<c:forEach items="${dados.LISTA}" var="l">
		          		<tr>
		          			<td>${l.id}</td>
		          			<td>${l.aparelho}</td>
		          			<td>${l.tipoOperacao}</td>
		          			<td>${l.pessoa}</td>
		          			<td>${l.tipoPessoa}</td>
		          			<td>
		          				<a href="javascript: salvarPermissao(${l.id})" class="btn btn-sm"><i class="bi bi-trash" style="color: red"></i></a>
		          			</td>
		          		</tr>
		          	</c:forEach>
		          </tbody>
		        </table>
	        </c:otherwise>
		</c:choose>
      </div>
