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
		              <th scope="col">Pessoa</th>
		              <th scope="col">Tipo Pessoa</th>
		              <th scope="col">CPF</th>
		              <th scope="col">Data Entrada</th>
		              <th scope="col">Data Saída</th>
		              <th scope="col">Data Expiração</th>
		              <th scope="col">Responsável</th>
		              <th scope="col">Observação</th>
		              <th scope="col">Vinculado?</th>
		            </tr>
		          </thead>
		          <tbody>
		          	<c:forEach items="${dados.LISTA}" var="l">
		          		<tr>
		          			<td>${l.id}</td>
		          			<td>${l.pessoa}</td>
		          			<td>${l.tipoPessoa}</td>
		          			<td>${l.cpf}</td>
		          			<td>${l.dataEntrada}</td>
							<td>${l.dataSaida}</td>
							<td style="<c:if test="${l.expirado == 'S'}">color: red</c:if>">${l.dataExpiracao}</td>
							<td>${l.responsavel}</td>
							<td>${l.observacao}</td>
							<td>${l.viculado}</td>
		          		</tr>
		          	</c:forEach>
		          </tbody>
		        </table>
	        </c:otherwise>
		</c:choose>
      </div>
