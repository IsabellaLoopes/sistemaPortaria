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
		              <th scope="col">ID</th>
		              <th scope="col">Data/Hora</th>
		              <th scope="col">Código</th>
		              <th scope="col">Pessoa</th>
		              <th scope="col">Tipo Pessoa</th>
		              <th scope="col">Aparelho</th>
		              <th scope="col">Tipo Operação</th>
		              <th scope="col">Situação</th>
		            </tr>
		          </thead>
		          <tbody>
		          	<c:forEach items="${dados.LISTA}" var="l">
		          		<tr>
		          			<td style="<c:if test="${l.situacao == 'Bloqueado'}">color: red</c:if>">${l.id}</td>
		          			<td style="<c:if test="${l.situacao == 'Bloqueado'}">color: red</c:if>">${l.dataAcesso}</td>
		          			<td style="<c:if test="${l.situacao == 'Bloqueado'}">color: red</c:if>"></td>
		          			<td style="<c:if test="${l.situacao == 'Bloqueado'}">color: red</c:if>">${l.pessoa}</td>
		          			<td style="<c:if test="${l.situacao == 'Bloqueado'}">color: red</c:if>">${l.tipoPessoa}</td>
		          			<td style="<c:if test="${l.situacao == 'Bloqueado'}">color: red</c:if>">${l.aparelho}</td>
		          			<td style="<c:if test="${l.situacao == 'Bloqueado'}">color: red</c:if>">${l.tipoOperacao}</td>
		          			<td style="<c:if test="${l.situacao == 'Bloqueado'}">color: red</c:if>">${l.situacao}</td>
		          		</tr>
		          	</c:forEach>
		          </tbody>
		        </table>
	        </c:otherwise>
		</c:choose>
      </div>
