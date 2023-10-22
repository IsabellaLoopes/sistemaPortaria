<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

	<!-- Titulo da pgina -->
	<div class="table-responsive-lg pb-5 containerForm">
	<p class="label-dashboard">Saída</p>
		<c:choose>
			<c:when test="${empty dados.LISTA}">
				<p>Não foi possível encontrar nenhum registro!</p>
			</c:when>
			<c:otherwise>
				<table class="table">
		          <thead>
		            <tr>
		              <th scope="col">Entrada</th>
		              <th scope="col">Aparelho Entrada</th>
		              <th scope="col">Código</th>
		              <th scope="col">Nome/Empresa</th>
		              <th scope="col">Tipo Pessoa</th>
		               <th scope="col">Saída</th>
		              <th scope="col">Aparelho Saída</th>
		              <th scope="col">Observação</th>
		            </tr>
		          </thead>
		          <tbody>
		          	<c:forEach items="${dados.LISTA}" var="l">
		          		<tr>
		          			<td>${l.dataEntrada}</td>
		          			<td>${l.aparelhoEntrada}</td>
		          			<td>${l.codigo}</td>
		          			<td>${l.pessoa}</td>
		          			<td>${l.tipoPessoa}</td>
		          			<td>${l.dataSaida}</td>
		          			<td>${l.aparelhoSaida}</td>
		          			<td>${l.observacao}</td>
		          		</tr>
		          	</c:forEach>
		          </tbody>
		        </table>
	        </c:otherwise>
		</c:choose>
      </div>
