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
		              <th scope="col">Nome</th>
		              <th scope="col">Apelido</th>
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
		          			<td>${l.usr_apelido}</td>
		          			<td>${l.usr_email}</td>
		          			<td>${l.usr_cpf}</td>
		          			<td>${l.usr_cnpj}</td>
		          			<td>${l.usr_telParticular}</td>
		          			<td>${l.usr_telCorporativo}</td>
		          			<td>${l.tip_descricao}</td>
		          			<td>							
								<div class="form-check form-switch">
									<input class="form-check-input" style="cursor: pointer;" type="checkbox" id="switchAtivo${l.usr_id}" <c:if test="${l.usr_statusDesc eq 'Ativo'}">checked</c:if> onchange="ativaInativaUsuario(${l.usr_id})">
									<label class="form-check-label" for="switchAtivo${l.usr_id}"></label>
								</div>
		          			</td>
		          			<td>
		          				<a href="javascript: editarUsuario(${l.usr_id})" class="btn btn-sm"><i class="bi bi-pencil-square"></i></a>
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

function ativaInativaUsuario(id){
	let param = {
			id: id,
			status: $("#switchAtivo"+id).attr("checked")=="checked" ? "N" : "S"
	}
	
	$.post("${pageContext.request.contextPath}/adm/statusUsuario", param, function(retorno){
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
		pesquisarUsuario()
	})
}

function editarUsuario(id){
   	let params = {id: id}
   	
   	$("#modal-responsive").empty().html()
   	$("#modal-responsive").load("${pageContext.request.contextPath}/adm/usuarioEditar", params, function(){
   		$("#modal-editar-usuario").modal("show")
   	})
}
</script>