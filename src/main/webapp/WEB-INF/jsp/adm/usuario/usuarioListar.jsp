<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
	<!-- Titulo da pgina -->
	<div class="table-responsive-lg pb-5">
		<c:choose>
			<c:when test="${empty dados.LISTA}">
				<p>Não foi possível encontrar nenhum registro!</p>
			</c:when>
			<c:otherwise>
				<table class="table" id="tb-especie">
		          <thead>
		            <tr>
		              <th scope="col">Nome</th>
		              <th scope="col">E-mail</th>
		              <th scope="col">CPF</th>
		              <th scope="col">CNPJ</th>
		              <th scope="col">Tel. Pessoal</th>
		              <th scope="col">Tel. Coorporativo</th>
		              <th scope="col">Tipo</th>
		              <th scope="col">Status</th>
		              <th scope="col">Ações</th>
		            </tr>
		          </thead>
		          <tbody>
		          	<c:forEach items="${dados.LISTA}" var="l">
		          		<tr>
		          			<td>${l.usr_nome}</td>
		          			<td>${l.usr_email}</td>
		          			<td>${l.usr_cpf}</td>
		          			<td>${l.usr_cnpj}</td>
		          			<td>${l.usr_telParticular}</td>
		          			<td>${l.usr_telCorporativo}</td>
		          			<td>${l.tip_descricao}</td>
		          			<td>${l.usr_statusDesc}</td>
		          			<td>
		          				<!-- <a href="javascript: editarEspecie(${l.id}, ${l.idTipoProduto}, '${l.tipoProduto}')" class="btn btn-sm btn-info"><i class="bi bi-pencil-square text-light"></i></a>  -->
		          			</td>
		          		</tr>
		          	</c:forEach>
		          </tbody>
		        </table>
	        </c:otherwise>
		</c:choose>
      </div>
<script>
$(document).ready(function (){
	//configurarTabela('tb-especie', false, false, false);
})

function editarEspecie(id, idTipoProduto, tipoProduto){
   	let params = {id: id, tipoProduto: idTipoProduto, tipoProdutoDescricao: tipoProduto}
   	
   	$("#especie-atacadista-modal").empty().html(getCarregando())
   	$("#especie-atacadista-modal").load("${pageContext.request.contextPath}/atacadista/especie/editar", params, function(){
   		$("#especie-editar-modal").modal("show")
   	})
}
</script>