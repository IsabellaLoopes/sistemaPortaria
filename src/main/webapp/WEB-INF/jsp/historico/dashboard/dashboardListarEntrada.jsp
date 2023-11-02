<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

	<!-- Titulo da pgina -->
	<div class="table-responsive-lg pb-5 containerForm">
	<p class="label-dashboard">Entrada</p>
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
		              <th scope="col">Observação</th>
		              <th scope="col">Ações</th>
		            </tr>
		          </thead>
		          <tbody>
		          	<c:forEach items="${dados.LISTA}" var="l">
		          		<tr>
		          			<td>${l.dataEntrada}</td>
		          			<td>${l.aparelhoEntrada}</td>
		          			<td>${l.codigo}</td>
		          			<td>
		          				<a style="cursor: help; text-decoration: underline;" data-toggle="tooltip" title="<img src='${pageContext.request.contextPath}/vizualizar/imagem/foto?id=${l.pes_id}' />">
						     		${l.pessoa}
						     	</a>
		          			</td>
		          			<td>${l.tipoPessoa}</td>
		          			<td>${l.observacao}</td>
		          			<td></td>
		          		</tr>
		          	</c:forEach>
		          </tbody>
		        </table>
	        </c:otherwise>
		</c:choose>
      </div>
     
<script type="text/javascript">
$('[data-toggle="tooltip"]').tooltip({
    animated: 'fade',
    placement: 'bottom',
    html: true
});
</script>
	  
       <!-- <script type="text/javascript">
      $(document).ready(function(){
      	setTimeout(function() {window.location.reload(1);}, 10000); 
      })
	  </script> -->
