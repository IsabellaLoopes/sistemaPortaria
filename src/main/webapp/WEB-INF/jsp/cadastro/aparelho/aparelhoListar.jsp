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
				<table class="table" id="tb-especie">
		          <thead>
		            <tr>
		              <th scope="col">Id</th>
		              <th scope="col">Descrição</th>
		              <th scope="col">Tipo Operação</th>
		              <th scope="col">IP</th>
		              <th scope="col">Status</th>
		              <th scope="col">Ações</th>
		            </tr>
		          </thead>
		          <tbody>
		          	<c:forEach items="${dados.LISTA}" var="l">
		          		<tr>
		          			<td>${l.apa_id}</td>
		          			<td>${l.apa_descricao}</td>
		          			<td>${l.tip_descricao}</td>
		          			<td>${l.apa_ip}</td>
		          			<td>							
								<div class="form-check form-switch">
									<input class="form-check-input" style="cursor: pointer;" type="checkbox" id="switchAtivo${l.apa_id}" <c:if test="${l.apa_statusDesc eq 'Ativo'}">checked</c:if> onchange="ativaInativaAparelho(${l.apa_id})">
									<label class="form-check-label" for="switchAtivo${l.apa_id}"></label>
								</div>
		          			</td>
		          			<td>
		          				<a href="javascript: editarAparelho(${l.pes_id})" class="btn btn-sm"><i class="bi bi-pencil-square"></i></a>
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

function ativaInativaAparelho(id){
	let param = {
			id: id,
			status: $("#switchAtivo"+id).attr("checked")=="checked" ? "N" : "S"
	}
	
	$.post("${pageContext.request.contextPath}/cadastro/aparelhoStatus", param, function(retorno){
		let obj = JSON.parse(retorno);
		
		if(obj.DATA.erro == 0){
			Swal.fire({
				  title: 'Sucesso!',
				  text: obj.DATA.mensagem,
				  icon: 'success',
				  confirmButtonText: 'Ok'
				})
		} else{
			Swal.fire({
				  title: 'Ops!',
				  text: obj.DATA.mensagem,
				  icon: 'error',
				  confirmButtonText: 'Ok'
				})
		}
		pesquisarAparelho()
	})
}

function editarAparelho(id){
   	let params = {id: id}
   	
   	$("#modal-responsive").empty().html()
   	$("#modal-responsive").load("${pageContext.request.contextPath}/cadastro/aparelhoEditar", params, function(){
   		$("#modal-editar-aparelho").modal("show")
   	})
}
</script>